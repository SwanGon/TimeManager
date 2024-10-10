defmodule Timemanager.UserManagerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.UserManager` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some@email.com",
        username: "some username"
      })
      |> Timemanager.UserManager.create_user()

    user
  end
end
