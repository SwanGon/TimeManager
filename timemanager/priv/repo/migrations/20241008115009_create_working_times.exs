defmodule Timemanager.Repo.Migrations.CreateWorkingTimes do
  use Ecto.Migration

  def change do
    create table(:working_times) do
      add :start, :utc_datetime
      add :end, :utc_datetime
      add :user_id, references(:users)

      timestamps(type: :utc_datetime)
    end
  end
end