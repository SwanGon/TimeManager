defmodule Timemanager.TeamManagersTest do
  use Timemanager.DataCase

  alias Timemanager.TeamManagers

  describe "teams" do
    alias Timemanager.TeamManagers.Team

    import Timemanager.TeamManagersFixtures

    @invalid_attrs %{}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert TeamManagers.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert TeamManagers.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{}

      assert {:ok, %Team{} = team} = TeamManagers.create_team(valid_attrs)
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TeamManagers.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{}

      assert {:ok, %Team{} = team} = TeamManagers.update_team(team, update_attrs)
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = TeamManagers.update_team(team, @invalid_attrs)
      assert team == TeamManagers.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = TeamManagers.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> TeamManagers.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = TeamManagers.change_team(team)
    end
  end
end
