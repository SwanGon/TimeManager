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
        end: ~U[2024-10-08 17:10:33Z],
        start: ~U[2024-10-08 09:05:23Z]
      })
      |> Timemanager.WorkingTimeManager.create_working_time()

    working_time
  end
end
