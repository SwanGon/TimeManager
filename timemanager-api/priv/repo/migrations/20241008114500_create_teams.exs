defmodule Timemanager.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :manager_id, references(:users, on_delete: :nothing), null: false
      timestamps(type: :utc_datetime)
    end

    create unique_index(:teams, [:manager_id])

    alter table(:users) do
      add :team_id, references(:teams, on_delete: :nilify_all)
    end
  end


end
