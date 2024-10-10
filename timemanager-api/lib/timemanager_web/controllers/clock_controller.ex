defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller

  alias Timemanager.ClockManager
  alias Timemanager.ClockManager.Clock

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    clocks = ClockManager.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- ClockManager.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock}")
      |> render(:show, clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = ClockManager.get_clock!(id)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = ClockManager.get_clock!(id)

    with {:ok, %Clock{} = clock} <- ClockManager.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = ClockManager.get_clock!(id)

    with {:ok, %Clock{}} <- ClockManager.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
