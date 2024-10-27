defmodule TimemanagerWeb.RoleController do
  use TimemanagerWeb, :controller
  use PhoenixSwagger

  alias Timemanager.RoleManager
  alias Timemanager.RoleManager.Role
  alias TimemanagerWeb.Swagger.RoleSwagger

  action_fallback TimemanagerWeb.FallbackController

  Module.eval_quoted(__MODULE__, RoleSwagger.paths())

  def index(conn, _params) do
    IO.inspect("test index")
    roles = RoleManager.list_roles()
    render(conn, :index, roles: roles)
  end


  def show(conn, %{"id" => id}) do
    IO.inspect("test show")
    case RoleManager.get_role!(id) do
      %Role{} = role ->
        render(conn, :show, role: role)
      _ ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Role not found"})
    end
  end

  def swagger_definitions do
    RoleSwagger.swagger_definitions()
  end
end
