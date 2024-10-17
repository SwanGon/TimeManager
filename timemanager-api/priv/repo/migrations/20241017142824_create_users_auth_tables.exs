defmodule Timemanager.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    unless table_exists?(:users) do
      create table(:users) do
        add :username, :string
        add :email, :citext, null: false
        add :hashed_password, :string, null: false
        add :confirmed_at, :utc_datetime

        timestamps(type: :utc_datetime)
      end

      create unique_index(:users, [:email])
    end
    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string

      timestamps(type: :utc_datetime, updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
  defp table_exists?(table_name) do
    query = "SELECT to_regclass($1) IS NOT NULL"
    {:ok, %{rows: [[exists]]}} = Ecto.Adapters.SQL.query(Timemanager.Repo, query, [to_string(table_name)])
    exists
  end
end
