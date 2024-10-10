defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller
  use PhoenixSwagger

  alias Timemanager.UserManager
  alias Timemanager.UserManager.User

  action_fallback TimemanagerWeb.FallbackController

  swagger_path :index do
    get "/api/users"
    description "List all users"
    produces "application/json"
    tag "Users"
    response 200, "Success"
    response 400, "Client Error"
  end

  def index(conn, _params) do
    users = UserManager.list_users()
    render(conn, :index, users: users)
  end

  def swagger_definitions do
  %{
    CreateUser: swagger_schema do
      title "Create User"
      description "Schema for creating a user"
      properties do
        username :string, "Username", example: "JohnDoe123", required: true
        email :string, "Email address", example: "mymail@testmail.com", required: true
      end
    end,
    User: swagger_schema do
      title "User"
      description "User details"
      properties do
        username :string, "Username"
        email :string, "Email address"
      end
      example %{
        username: "JohnDoe123",
        email: "mymail@testmail.com"
      }
    end
  }
  end

  swagger_path :create do
    post "/api/users"
    description "Create user"
    produces "application/json"
    tag "Users"
    parameters do
      body :body, Schema.ref(:CreateUser), "User creation params", required: true
    end
    response 201, "Success", Schema.ref(:User)
    response 400, "Client Error"
  end

  def create(conn, %{"username" => username, "email" => email}) do
    user_params = %{"username" => username, "email" => email}

    with {:ok, %User{} = user} <- UserManager.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user.id}")
      |> render(:show, user: user)
    else
      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Unable to create user"})
    end
  end

  swagger_path :show do
    get "/api/users/{id}"
    description "Get user by id"
    produces "application/json"
    tag "Users"
    parameter :id, :path, :integer, "User ID", required: true, example: 3
    response 200, "Success"
    response 400, "Client Error"
  end

  def show(conn, %{"id" => id}) do
    user = UserManager.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "username" => username, "email" => email}) do
    user = UserManager.get_user!(id)
    user_params = %{"username" => username, "email" => email}

    with {:ok, %User{} = updated_user} <- UserManager.update_user(user, user_params) do
      render(conn, :show, user: updated_user)
    else
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Unable to update user", details: changeset})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = UserManager.get_user!(id)

    with {:ok, %User{}} <- UserManager.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
