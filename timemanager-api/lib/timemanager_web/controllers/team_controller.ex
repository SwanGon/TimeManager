defmodule TimemanagerWeb.TeamController do
  use TimemanagerWeb, :controller

  use PhoenixSwagger

  alias Timemanager.TeamManagers
  alias Timemanager.TeamManagers.Team

  alias TimemanagerWeb.Swagger.TeamSwagger

  action_fallback TimemanagerWeb.FallbackController

  Module.eval_quoted(__MODULE__, TeamSwagger.paths())

  def index(conn, _params) do
    teams = TeamManagers.list_teams()
    render(conn, :index, teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- TeamManagers.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/teams/#{team}")
      |> render(:show, team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = TeamManagers.get_team!(id)
    render(conn, :show, team: team)
  end

  def manager(conn, %{"manager_id" => manager_id}) do
    team = TeamManagers.get_team_by_manager(manager_id)
    render(conn, :show, team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = TeamManagers.get_team!(id)

    with {:ok, %Team{} = team} <- TeamManagers.update_team(team, team_params) do
      render(conn, :show, team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = TeamManagers.get_team!(id)

    with {:ok, %Team{}} <- TeamManagers.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    TeamSwagger.swagger_definitions()
  end
end
