defmodule Timemanager.WorkingTimeManager.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset
  alias Timemanager.UserManager.User
  alias Timemanager.ClockManager.Clock

  schema "working_times" do
    belongs_to :clock_start, Clock
    belongs_to :clock_end, Clock
    belongs_to :user, User
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:clock_start, :clock_end])
    |> validate_required([:clock_start, :clock_end])
    |> validate_start_before_end()
  end

  defp validate_start_before_end(changeset) do
    start_time = get_field(changeset, :clock_start)
    end_time = get_field(changeset, :clock_end)

    # Only validate if both start and end are present
    if start_time && end_time && DateTime.compare(start_time, end_time) != :lt do
      add_error(changeset, :clock_start, "must be before end time")
    else
      changeset
    end
  end
end
