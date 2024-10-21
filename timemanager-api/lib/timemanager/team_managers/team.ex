defmodule Timemanager.TeamManagers.Team do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  schema "teams" do

    field :manager_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:manager_id])
    |> validate_required([:manager_id])
    |> unique_constraint(:manager_id, name: :teams_manager_id_index, message: "Each team can only have one manager")
    |> validate_manager_role()
  end

  defp validate_manager_role(changeset) do
    manager_id = get_field(changeset, :manager_id)

    if manager_id do
      query = from u in Timemanager.UserManager.User, where: u.id == ^manager_id and u.role == "manager"
      case Timemanager.Repo.one(query) do
        nil -> add_error(changeset, :manager_id, "Selected user is not a manager")
        _user -> changeset
      end
    else
      changeset
    end
  end
end
