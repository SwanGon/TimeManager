defmodule Timemanager.WorkingTimeManager.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "working_times" do
    field :working_start, :utc_datetime
    field :working_end, :utc_datetime
    field :user_id, :id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:working_start, :working_end, :user_id])
    |> validate_required([:working_start, :working_end, :user_id])
    |> validate_start_before_end()
  end

  defp validate_start_before_end(changeset) do
    start_time = get_field(changeset, :working_start)
    end_time = get_field(changeset, :working_end)

    # Only validate if both start and end are present
    if start_time && end_time && DateTime.compare(start_time, end_time) != :lt do
      add_error(changeset, :working_start, "must be before end time")
    else
      changeset
    end
  end
end
