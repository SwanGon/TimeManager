defmodule Timemanager.WorkingTimeManager.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset
  alias Timemanager.UserManager.User

  schema "working_times" do
    field :start, :utc_datetime
    field :end, :utc_datetime
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
    |> validate_start_before_end()
  end

  defp validate_start_before_end(changeset) do
    start_time = get_field(changeset, :start)
    end_time = get_field(changeset, :end)

    # Only validate if both start and end are present
    if start_time && end_time && DateTime.compare(start_time, end_time) != :lt do
      add_error(changeset, :start, "must be before end time")
    else
      changeset
    end
  end
end

