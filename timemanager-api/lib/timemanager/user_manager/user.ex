defmodule Timemanager.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :role_id, :id


    has_many :clocks, Timemanager.ClockManager.Clock
    has_many :working_times, Timemanager.WorkingTimeManager.WorkingTime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :role_id])
    |> validate_required([:username, :email, :role_id])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/)
    |> unique_constraint(:email)
    |> validate_length(:username, min: 3)
  end
end
