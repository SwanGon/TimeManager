defmodule Timemanager.WorkingTimeManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.WorkingTimeManager` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~U[2024-10-07 11:50:00Z],
        start: ~U[2024-10-07 11:50:00Z]
      })
      |> Timemanager.WorkingTimeManager.create_working_time()

    working_time
  end
end
