defmodule Timemanager.TeamManagersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.TeamManagers` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{

      })
      |> Timemanager.TeamManagers.create_team()

    team
  end
end
