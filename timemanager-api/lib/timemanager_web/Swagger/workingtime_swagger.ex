defmodule TimemanagerWeb.Swagger.WorkingtimeSwagger do
  use PhoenixSwagger

  def swagger_definitions do
    %{
      Workingtime: swagger_schema do
        title "Workingtime"
        description "Workingtime details"
        properties do
          working_start :datetime, "Start"
          working_end :datetime, "end"
          user :integer, "User ID"
        end
        example %{
          working_start: "2024-12-30 15:46:33",
          working_end: "2024-12-30 15:46:33",
          user: "User ID"
        }
      end,

      CreateWorkingtime: swagger_schema do
        title "Create Workingtime"
        description "Schema for creating a workingtime"
        properties do
          working_start :datetime, "Start", example: "2024-12-30 09:46:33", required: true
          working_end :datetime, "End", example: "2024-12-30 16:46:33", required: true
        end
      end,

      UpdateWorkingtime: swagger_schema do
        title "Update Workingtime"
        description "Schema for updating a workingtime"
        properties do
          working_start :datetime, "Start", example: "2024-12-30 10:46:33", required: true
          working_end :datetime, "End", example: "2024-12-30 17:46:33", required: true
        end
      end,
    }
  end

  def paths do
    quote do

      swagger_path :index do
        get "/api/workingtimes/{user_id}"
        description "List all working times of a user"
        produces "application/json"
        tag "Workingtime"

        parameter :user_id, :path, :integer, "User ID", required: true
        parameter :working_start, :query, :string, "start date", required: false
        parameter :working_end, :query, :string, "end date", required: false

        response 200, "Success"
        response 400, "Client Error"
      end


      swagger_path :show do
        get "/api/workingtimes/{user_id}/"
        description "Get a working time by user by id"
        produces "application/json"
        tag "Workingtime"

        parameter :id, :query, :integer, "Working time ID", required: true
        parameter :user_id, :path, :integer, "User ID", required: true

        response 200, "Success"
        response 400, "Client Error"
        response 404, "No working time and/or user found with this IDs"
      end

      swagger_path :create do
        post "/api/workingtimes/{user_id}/"
        description "Create workingtime"
        produces "application/json"
        tag "Workingtime"
        parameters do
          user_id :path, :integer, "User ID", required: true, example: 1
          body :body, Schema.ref(:CreateWorkingtime), "Workingtime creation params", required: true
        end
        response 201, "Success", Schema.ref(:Workingtime)
        response 400, "Client Error"
      end

      swagger_path :update do
        put "/api/workingtimes/{id}"
        description "Update an existing user"
        produces "application/json"
        tag "Workingtime"
        parameters do
          id :path, :integer, "working time id", required: true, example: 1
          body :body, Schema.ref(:UpdateWorkingtime), "working time update params", required: true
        end
        response 200, "Working time updated", Schema.ref(:Workingtime)
        response 400, "Client Error"
      end

      swagger_path :delete do
        PhoenixSwagger.Path.delete "/api/workingtimes/{id}"
        summary "Delete User"
        description "Delete a user by ID"
        tag "Workingtime"
        parameter :id, :path, :integer, "Working time ID", required: true, example: 1
        response 204, "No Content - Deleted Successfully"
      end
    end
  end
end
