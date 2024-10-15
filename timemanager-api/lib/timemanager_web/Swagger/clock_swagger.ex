defmodule TimemanagerWeb.Swagger.ClockSwagger do
  use PhoenixSwagger

  def swagger_definitions do
    %{
      CreateClock: swagger_schema do
        title "Create Clock"
        description "Schema for creating a clock"
        properties do
          time :datetime, "Time", example: "2024-12-30 15:46:33", required: true
          status :boolean, "Status", example: "true"
        end
      end,
      Clock: swagger_schema do
        title "Clock"
        description "Clock details"
        properties do
          time :datetime, "Time"
          status :boolean, "Status"
          user :integer, "User ID"
        end
        example %{
          time: "JohnDoe123",
          status: "mymail@testmail.com",
          user: "User ID"
        }
      end,
    }
  end

  def paths do
    quote do
      swagger_path :index do
        get "/api/clocks"
        description "List all clocks"
        produces "application/json"
        tag "Clocks"
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :create do
        post "/api/clocks/{id}"
        description "Create clock"
        produces "application/json"
        tag "Clocks"
        parameters do
          id :path, :integer, "User ID", required: true, example: 1
          body :body, Schema.ref(:CreateClock), "Clock creation params", required: true
        end
        response 201, "Success", Schema.ref(:Clock)
        response 400, "Client Error"
      end

      swagger_path :show do
        get "/api/clocks/{id}"
        description "Get clock by id"
        produces "application/json"
        tag "Clocks"
        parameter :id, :path, :integer, "Clock ID", required: true, example: 3
        response 200, "Success"
        response 400, "Client Error"
      end
    end
  end
end
