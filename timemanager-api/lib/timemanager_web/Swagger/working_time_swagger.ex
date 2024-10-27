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
      end
    }
  end

  def paths do
    quote do

      swagger_path :index do
        get "/api/workingtimes/{user_id}"
        description "List all working times of a user, with possibility to get after a starting date and/or before a ending date"
        produces "application/json"
        tag "Workingtime"
        parameter :user_id, :path, :integer, "User ID", required: true, default: 1
        parameter :working_start, :query, :string, "start date", required: false, default: "2024-10-25T00:00:00Z"
        parameter :working_end, :query, :string, "end date", required: false, default: "2024-10-28T23:59:59Z"
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No working times/user/working start/end found with this parameters"
      end

      swagger_path :today do
        get "/api/workingtimes/today/{user_id}"
        description "Get a working time for the current day by user by id"
        produces "application/json"
        tag "Workingtime"
        parameter :user_id, :path, :integer, "User ID", required: true
        parameter :start_of_day, :query, :string, "today at 00:00", required: true, default: "2024-10-29T00:00:00Z"
        parameter :end_of_day, :query, :string, "today at 23:59", required: true, default: "2024-10-29T23:59:59Z"
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No working time and/or user found with this IDs"
      end

      swagger_path :show do
        get "/api/workingtimes/{user_id}"
        description "Get a working time by user by id"
        produces "application/json"
        tag "Workingtime"
        parameter :user_id, :path, :integer, "User ID", required: true, default: 1
        response 200, "Success"
        response 400, "Client Error"
        response 404, "No working time and/or user found with this IDs"
      end

      swagger_path :create do
        post "/api/workingtimes/{user_id}"
        description "Create workingtime"
        produces "application/json"
        tag "Workingtime"
        parameter :user_id, :path, :integer, "User ID", required: true, default: 1
        parameter :working_start, :query, :string, "start date", required: false, default: "2024-10-25T09:00:00Z"
        parameter :working_end, :query, :string, "end date", required: false, default: "2024-10-28T17:30:00Z"
        response 201, "Success"
        response 400, "Client Error"
      end

      swagger_path :update do
        put "/api/workingtimes/{id}"
        description "Update an existing working time"
        produces "application/json"
        tag "Workingtime"
        parameter :id, :path, :integer, "Working time id", required: true, default: 1
        parameter :working_start, :query, :string, "start date", required: false, default: "2024-10-25T09:30:00Z"
        parameter :working_end, :query, :string, "end date", required: false, default: "2024-10-28T18:00:00Z"
        response 200, "Working time updated"
        response 400, "Client Error"
      end

      swagger_path :delete do
        PhoenixSwagger.Path.delete "/api/workingtimes/{id}"
        description "Delete a working time by ID"
        tag "Workingtime"
        parameter :id, :path, :integer, "Working time ID", required: true, default: 1
        response 204, "No Content - Deleted Successfully"
      end
    end
  end
end
