defmodule TimemanagerWeb.Swagger.RoleSwagger do
  use PhoenixSwagger

  def swagger_definitions do
    %{
      CreateRole: swagger_schema do
        title "Create Role"
        description "Schema for creating a Role"
        properties do
          title :string, "title", example: "user/manager/supervisor", required: true
        end
      end,
      Role: swagger_schema do
        title "Role"
        description "Role details"
        properties do
          title :string, "Time"
        end
        example %{
          title: 'user'
        }
      end
    }
  end

  def paths do
    quote do
      swagger_path :index do
        get "/api/roles"
        description "List all roles"
        produces "application/json"
        tag "Roles"

        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :show do
        get "/api/roles/{id}"
        description "Get role by id"
        produces "application/json"
        tag "Roles"
        parameter :id, :path, :integer, "Role id", required: true
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No roles found with this ID"
      end


    end
  end
end
