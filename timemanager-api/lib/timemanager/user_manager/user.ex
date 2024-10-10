defmodule Timemanager.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    has_many :clocks, Timemanager.ClockManager.Clock, on_delete: :delete_all
    has_many :working_times, Timemanager.WorkingTimeManager.WorkingTime, on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/)
    |> unique_constraint(:email)
    |> validate_length(:username, min: 3)
  end
end
