defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller
  use PhoenixSwagger

  alias Timemanager.UserManager
  alias Timemanager.UserManager.User
  alias TimemanagerWeb.Swagger.UserSwagger

  action_fallback TimemanagerWeb.FallbackController

  Module.eval_quoted(__MODULE__, UserSwagger.paths())

  def index(conn, params) do
    users =
      cond do
        params["email"] && params["username"] ->
          UserManager.get_users_by_email_and_username(params["email"], params["username"])
        params["email"] ->
          UserManager.get_users_by_email(params["email"])
        params["username"] ->
          UserManager.get_users_by_username(params["username"])
        true ->
          UserManager.list_users()
        end
    render(conn, :index, users: users)
  end

  def managers(conn, _params) do
    managers = UserManager.get_managers()
    render(conn, :index, users: managers)
  end

  def create(conn, %{"username" => username, "email" => email, "role_id" => role_id}) do
    user_params = %{"username" => username, "email" => email, "role_id" => role_id}

    with {:ok, %User{} = user} <- UserManager.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user.id}")
      |> render(:show, user: user)
    else
      g ->
        IO.inspect(g)
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Unable to create user"})
    end
  end
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- UserManager.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user.id}")
      |> render(:show, user: user)
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => "me"}) do
    case conn.assigns do
      %{current_user: user} when not is_nil(user) ->
        render(conn, :show, user: user)
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "User not authenticated"})
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
  def log_in(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params


    if user = UserManager.get_user_by_email_and_password(email, password) do
      token = Timemanager.JWTToken.generate_user_token(user)
      csrf_token = Timemanager.UserManager.UserToken.generate_csrf_token()

      conn
      |> put_status(:ok)
      |> render("login.json", %{user: user, token: token, csrf_token: csrf_token})
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Invalid email or password"})
    end
  end
end
