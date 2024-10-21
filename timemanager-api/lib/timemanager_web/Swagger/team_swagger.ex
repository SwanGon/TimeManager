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

      CreateTeam: swagger_schema do
        title "Create Team"
        description "Schema for creating a Team"
        properties do
          manager_id :integer, "manager_id", example: 1, required: true, default: 1
        end
      end,

      UpdateTeam: swagger_schema do
        title "Update Team"
        description "Schema for updating a Team"
        properties do
          manager_id :integer, "manager_id", example: 2, required: true, default: 2
        end
      end,
    }
  end

  def paths do
    quote do
      swagger_path :index do
        get "/api/teams"
        description "List all team"
        produces "application/json"
        tag "Teams"
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :show do
        get "/api/teams/{id}"
        description "Get team by id"
        produces "application/json"
        tag "Teams"
        parameter :id, :path, :integer, "Team ID", required: true
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No Team found with this ID"
      end

      swagger_path :create do
        post "/api/teams"
        description "Create Team"
        produces "application/json"
        tag "Teams"
        parameters do
          body :body, Schema.ref(:CreateTeam), "Team creation params", required: true
        end
        response 201, "Success", Schema.ref(:Team)
        response 400, "Client Error"
      end

      swagger_path :update do
        put "/api/teams/{id}"
        description "Update an existing team"
        produces "application/json"
        tag "Teams"
        parameters do
          id :path, :integer, "Team ID", required: true, example: 1
          body :body, Schema.ref(:UpdateTeam), "Team update params", required: true
        end
        response 200, "Team updated", Schema.ref(:Team)
        response 400, "Client Error"
      end

      swagger_path :delete do
        PhoenixSwagger.Path.delete "/api/teams/{id}"
        summary "Delete Team"
        description "Delete a Team by ID"
        tag "Teams"
        parameter :id, :path, :integer, "Team ID", required: true, example: 3
        response 204, "No Content - Deleted Successfully"
      end
    end
  end

end
