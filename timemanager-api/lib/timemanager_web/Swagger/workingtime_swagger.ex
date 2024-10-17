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
          user_id :integer, "User ID"
        end
        example %{
          working_start: "2024-12-30 15:46:33",
          working_end: "2024-12-30 15:46:33",
          user_id: "User ID"
        }
      end,

      CreateWorkingtime: swagger_schema do
        title "Create Workingtime"
        description "Schema for creating a workingtime"
        properties do
          working_start :datetime, "Start", example: "2024-12-30 09:46:33", required: true
          working_end :datetime, "End", example: "2024-12-30 16:46:33", required: true
          user_id :integer, "User ID", example: 1, required: true
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
      swagger_path :create do
        post "/api/workingtimes"
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
