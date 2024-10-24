defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller
  use PhoenixSwagger

  alias Timemanager.ClockManager
  alias Timemanager.ClockManager.Clock
  alias TimemanagerWeb.Swagger.ClockSwagger

  action_fallback TimemanagerWeb.FallbackController

  Module.eval_quoted(__MODULE__, ClockSwagger.paths())

  def index(conn, params) do
    clocks =
      cond do
        params["time"] && params["user_id"]->
          ClockManager.list_clocks_by_user_and_date(params["user_id"],params["time"])
        true ->
          ClockManager.get_clocks_by_user(params["user_id"])
      end
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"time" => time, "status" => status, "user_id"=> user_id}) do
    clock_params = %{"time" => time, "status" => status, "user_id"=> user_id}

    with {:ok, %Clock{} = clock} <- ClockManager.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock.id}")
      |> render(:show, clock: clock)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   case ClockManager.get_clock!(id) do
  #     %Clock{} = clock ->
  #       render(conn, :show, clock: clock)
  #     _ ->
  #       conn
  #       |> put_status(:not_found)
  #       |> json(%{error: "Clock not found"})
  #   end
  # end

  # def update(conn, %{"id" => id, "clock" => clock_params}) do
  #   clock = ClockManager.get_clock!(id)

  #   with {:ok, %Clock{} = clock} <- ClockManager.update_clock(clock, clock_params) do
  #     render(conn, :show, clock: clock)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   clock = ClockManager.get_clock!(id)

  #   with {:ok, %Clock{}} <- ClockManager.delete_clock(clock) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end

  def swagger_definitions do
    ClockSwagger.swagger_definitions()
  end
end
