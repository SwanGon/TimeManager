defmodule Timemanager.ClockManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.ClockManager` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2024-10-07 11:48:00Z]
      })
      |> Timemanager.ClockManager.create_clock()

    clock
  end
end
