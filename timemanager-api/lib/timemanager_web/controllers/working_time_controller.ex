defmodule TimemanagerWeb.WorkingTimeController do
  use TimemanagerWeb, :controller
  use PhoenixSwagger

  alias Timemanager.WorkingTimeManager
  alias Timemanager.WorkingTimeManager.WorkingTime

  alias TimemanagerWeb.Swagger.WorkingtimeSwagger

  action_fallback TimemanagerWeb.FallbackController

  Module.eval_quoted(__MODULE__, WorkingtimeSwagger.paths())

  def index(conn, params) do
    working_times =
      cond do
        params["working_start"] && params["working_end"] ->
          WorkingTimeManager.get_working_times_by_user_start_and_end(params["working_start"], params["working_end"],params["user_id"])
        params["working_start"] ->
          WorkingTimeManager.get_working_times_by_user_and_start(params["working_start"], params["user_id"])
        params["working_end"] ->
          WorkingTimeManager.get_working_times_by_user_and_end(params["working_end"], params["user_id"])
        true ->
          WorkingTimeManager.get_working_times_by_user(params["user_id"])
      end
    render(conn, "index.json", working_times: working_times)
  end

  def today(conn, %{ "user_id"=> user_id, "start_of_day" => start_of_day , "end_of_day" => end_of_day}) do
    working_times = WorkingTimeManager.get_todays_working_times(user_id, start_of_day, end_of_day)
    render(conn, :index, working_times: working_times)
  end

  def show(conn, %{"id" => id, "user_id"=> user_id}) do
    working_time = WorkingTimeManager.get_one_working_time!(id, user_id)
    render(conn, :show, working_time: working_time)
  end

  def create(conn, %{"working_start" => working_start, "working_end" => working_end, "user_id"=> user_id}) do
    working_time_params = %{"working_start" => working_start, "working_end" => working_end, "user_id"=> user_id}

    with {:ok, %WorkingTime{} = working_time} <- WorkingTimeManager.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{working_time}")
      |> render(:show, working_time: working_time)
    end
  end


  def update(conn, %{"id" => id, "working_start" => working_start, "working_end" => working_end}) do
    working_time_params = %{"working_start" => working_start, "working_end" => working_end}

    working_time = WorkingTimeManager.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- WorkingTimeManager.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = WorkingTimeManager.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTimeManager.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    WorkingtimeSwagger.swagger_definitions()
  end
end
