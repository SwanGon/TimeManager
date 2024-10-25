defmodule TimemanagerWeb.SessionController do
  use TimemanagerWeb, :controller

  alias Timemanager.Sessions.Session

  action_fallback(TimemanagerWeb.FallbackController)

  def login(conn, %{"email" => email, "password" => password}) do
    if user = Timemanager.UserManager.get_user_by_email_and_password(email, password) do
      token = TimemanagerWeb.Token.signJWT(%{user_id: user.id})
      token_csrf = TimemanagerWeb.Token.signCSRF(%{user_id: user.id})

      case {token, token_csrf} do
        {{:ok, token}, {:ok, token_csrf}} ->
          Timemanager.Sessions.create_session(%{
            user_id: user.id,
            token: token,
            ip: conn.remote_ip |> Tuple.to_list() |> Enum.join(".")
          })

          conn
          |> put_status(:ok)
          |> render(:token, %{user: user, token: token, csrf_token: token_csrf})

        _ ->
          conn
          |> put_status(:bad_request)
          |> render(:error, message: "Something went wrong")
      end
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Invalid email or password"})
    end
  end

  def logout(conn, _params) do
    with {:ok, %Session{}} <- Timemanager.Sessions.delete_session(conn.assigns[:session]) do
      send_resp(conn, :no_content, "")
    end
  end
end
