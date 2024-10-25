defmodule TimemanagerWeb.RoleJSON do
  alias Timemanager.RoleManager.Role

  def index(%{roles: roles}) do
    %{data: for(role <- roles, do: data(role))}
  end

  def show(%{role: role}) do
    %{data: data(role)}
  end

  def error(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end

  defp data(%Role{} = role) do
    %{
      id: role.id,
      name: role.title,
    }
  end
end
