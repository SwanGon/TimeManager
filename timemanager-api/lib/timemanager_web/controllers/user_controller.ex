defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller
  use PhoenixSwagger

  alias Timemanager.UserManager
  alias Timemanager.UserManager.User
  alias TimemanagerWeb.Swagger.UserSwagger

  action_fallback TimemanagerWeb.FallbackController

  Module.eval_quoted(__MODULE__, UserSwagger.paths())

  def index(conn, _params) do
    users = UserManager.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"username" => username, "email" => email, "role_id" => role_id}) do
    user_params = %{"username" => username, "email" => email, "role_id" => role_id}

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

  def swagger_definitions do
    UserSwagger.swagger_definitions()
  end
end
