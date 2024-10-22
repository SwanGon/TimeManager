defmodule Timemanager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
   execute "CREATE EXTENSION IF NOT EXISTS citext", ""

   create table(:users) do
        add :username, :string
        add :email, :citext, null: false
        add :hashed_password, :string, null: false
        add :confirmed_at, :utc_datetime
        add :role_id, references(:roles, on_delete: :nothing)

        timestamps(type: :utc_datetime)
      end

      create unique_index(:users, [:email])
    end
end
