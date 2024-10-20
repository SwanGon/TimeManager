defmodule Timemanager.UserManager do
  @moduledoc """
  The UserManager context.
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo

  alias Timemanager.UserManager.User
  alias Timemanager.RoleManager.Role

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  def get_users_by_email(email) do
    from(u in User, where: u.email == ^email)
    |> Repo.all()
  end

  def get_users_by_username(username) do
    from(u in User, where: u.username == ^username)
    |> Repo.all()
  end

  def get_users_by_email_and_username(email, username) do
    from(u in User, where: u.email == ^email and u.username == ^username)
  |> Repo.all()
  end

  def get_managers() do
    case get_manager_role_id() do
      nil -> []
      manager_role_id ->
        from(u in User, where: u.role_id == ^manager_role_id)
        |> Repo.all()
    end
  end

  defp get_manager_role_id() do
    Role
    |> where([r], r.title == "manager")
    |> select([r], r.id)
    |> Repo.one()
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
