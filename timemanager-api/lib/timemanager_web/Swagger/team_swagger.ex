defmodule TimemanagerWeb.Swagger.TeamSwagger do
  use PhoenixSwagger

  def swagger_definitions do
    %{
      Team: swagger_schema do
        title "Team"
        description "Team details"
        properties do
          manager_id :integer, "manager ID"
        end
        example %{
          manager_id: 1
        }
      end,
    }
  end

  def paths do
    quote do
      swagger_path :index do
        get "/api/teams"
        description "List all teams"
        produces "application/json"
        tag "Teams"
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :show do
        get "/api/teams/{id}"
        description "Get a team by id"
        produces "application/json"
        tag "Teams"
        parameter :id, :path, :integer, "Team ID", required: true, default: 1
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No Team found with this ID"
      end

      swagger_path :manager do
        get "/api/teamsmanager/{manager_id}"
        description "get a team by manager's id"
        produces "application/json"
        tag "Teams"
        parameter :manager_id, :path, :integer, "manager ID", required: true, default: 3
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No Team found with this ID"
      end


      swagger_path :create do
        post "/api/teams"
        description "Create Team"
        produces "application/json"
        tag "Teams"
        parameter :manager_id, :query, :integer, "manager ID", required: true, default: 7
        response 201, "Success", Schema.ref(:Team)
        response 400, "Client Error"
      end

      swagger_path :update do
        put "/api/teams/{id}"
        description "Update an existing team"
        produces "application/json"
        tag "Teams"
        parameter :id, :path, :integer, "Team ID", required: true, default: 1
        parameter :manager_id, :query, :integer, "manager ID", required: true, default: 7
        response 200, "Team updated", Schema.ref(:Team)
        response 400, "Client Error"
      end

      swagger_path :delete do
        PhoenixSwagger.Path.delete "/api/teams/{id}"
        description "Delete a team by ID"
        tag "Teams"
        parameter :id, :path, :integer, "Team ID", required: true
        response 204, "No Content - Deleted Successfully"
      end
    end
  end

end
