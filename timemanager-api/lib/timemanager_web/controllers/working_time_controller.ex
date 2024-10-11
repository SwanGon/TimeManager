defmodule TimemanagerWeb.WorkingTimeController do
  use TimemanagerWeb, :controller

  alias Timemanager.WorkingTimeManager
  alias Timemanager.WorkingTimeManager.WorkingTime

  action_fallback TimemanagerWeb.FallbackController

  Module.eval_quoted(__MODULE__, WorkingtimeSwagger.paths())

  def index(conn, _params) do
    working_times = WorkingTimeManager.list_working_times()
    render(conn, :index, working_times: working_times)
  end

  def create(conn, %{"working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- WorkingTimeManager.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{working_time}")
      |> render(:show, working_time: working_time)
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = WorkingTimeManager.get_working_time!(id)
    render(conn, :show, working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
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
