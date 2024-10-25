defmodule TimemanagerWeb.Plug.CheckUserAccess do
  import Plug.Conn
  import Phoenix.Controller

  def init(options), do: options

  def call(conn, _opts) do
    user_id = conn.assigns[:current_user].id
    params_user_id = conn.params["user_id"]

    if params_user_id == nil do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Missing user_id parameter"})
      |> halt()
    else
      params_user_id = String.to_integer(params_user_id)

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
end