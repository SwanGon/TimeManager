defmodule TimemanagerWeb.Plug.CheckUserAccess do
  import Plug.Conn
  import Phoenix.Controller

  def init(options), do: options

  def call(conn, _opts) do
    user_id = conn.assigns[:current_user].id
    params_user_id = String.to_integer(conn.params["user_id"])

    if user_id != params_user_id do
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Unauthorized"})
      |> halt()
    else
      conn
    end
  end
end
