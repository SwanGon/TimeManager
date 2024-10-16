defmodule TimemanagerWeb.Swagger.WorkingtimeSwagger do
  use PhoenixSwagger

  def swagger_definitions do
    %{
      CreateWorkingtime: swagger_schema do
        title "Create Workingtime"
        description "Schema for creating a workingtime"
        properties do
          clock_start :datetime, "Start", example: "2024-12-30 15:46:33", required: true
          clock_end :datetime, "End", example: "2024-12-30 15:46:33", required: true
        end
      end,
      Workingtime: swagger_schema do
        title "Workingtime"
        description "Workingtime details"
        properties do
          clock_start :datetime, "Start"
          clock_end :datetime, "end"
        end
        example %{
          clock_start: "2024-12-30 15:46:33",
          clock_end: "2024-12-30 15:46:33"
        }
      end,
      UpdateWorkingtime: swagger_schema do
        title "Update Workingtime"
        description "Schema for updating a workingtime"
        properties do
          username :string, "Username", example: "UpdatedUser123", required: true
          email :string, "Email address", example: "updatedmail@testmail.com", required: true
        end
      end,
    }
  end

  def paths do
    quote do
      swagger_path :create do
        post "/api/workingtime/{id}"
        description "Create workingtime"
        produces "application/json"
        tag "Workingtime"
        parameters do
          id :path, :integer, "User ID", required: true, example: 1
          body :body, Schema.ref(:CreateWorkingtime), "Workingtime creation params", required: true
        end
        response 201, "Success", Schema.ref(:Workingtime)
        response 400, "Client Error"
      end
    end
  end
end
