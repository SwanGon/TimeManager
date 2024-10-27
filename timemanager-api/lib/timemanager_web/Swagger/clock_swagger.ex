defmodule TimemanagerWeb.Swagger.ClockSwagger do
  use PhoenixSwagger

  def swagger_definitions do
    %{
      Clock: swagger_schema do
        title "Clock"
        description "Clock details"
        properties do
          time :datetime, "Time"
          status :boolean, "Status"
          user_id :integer, "User ID"
        end
        example %{
          time: "2024-10-29T15:00:00Z",
          status: "true",
          user_id: "User ID"
        }
      end,
    }
  end

  def paths do
    quote do
      swagger_path :index do
        get "/api/clocks/{user_id}"
        description "List all clocks"
        produces "application/json"
        tag "Clocks"

        parameter :user_id, :path, :integer, "User ID", required: true, default: 1
        response 200, "Success"
        response 400, "Client Error"
      end

      swagger_path :create do
        post "/api/clocks/{user_id}"
        description "Create clock"
        produces "application/json"
        tag "Clocks"

        parameter :user_id, :path, :integer, "user ID", required: true, default: 1
        parameter :time, :query, :string, "Time", default: "2024-10-29T15:00:00Z", required: true
        parameter  :status, :query, :boolean, "Status", default: "true", required: true

        response 201, "Success"
        response 400, "Client Error"
      end

      swagger_path :today do
        get "/api/clocks/today/{user_id}"
        description "Get clock by id"
        produces "application/json"
        tag "Clocks"

        parameter :user_id, :path, :integer, "user id", required: true, default: 1
        parameter :start_of_day, :query, :string, "today at 00:00", required: true, default: "2024-10-28T00:00:00Z"
        parameter :end_of_day, :query, :string, "today at 23:59", required: true, default: "2024-10-28T23:59:59Z"
        response 200, "Success"
        response 400, "Client Error"
      end
    end
  end
end
