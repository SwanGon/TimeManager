defmodule Timemanager.WorkingTimeManager do
  @moduledoc """
  The WorkingTimeManager context.
  """

  import Ecto.Query, warn: false
  alias Timemanager.Repo

  alias Timemanager.WorkingTimeManager.WorkingTime

  @doc """
  Returns the list of working_times.

  ## Examples

      iex> list_working_times()
      [%WorkingTime{}, ...]

  """
  # def list_working_times do
  #   Repo.all(WorkingTime)
  # end

  def get_working_times_by_user(user_id) do
    from(w in WorkingTime, where: w.user_id == ^user_id)
    |> Repo.all()
  end

  def get_working_times_by_user_start_and_end(working_start, working_end, user_id) do
    from(w in WorkingTime, where: w.user_id == ^user_id and w.working_start <= ^working_start and w.working_end >= ^working_end)
    |> Repo.all()
  end

  def get_working_times_by_user_and_start(working_start, user_id) do
    from(w in WorkingTime, where: w.user_id == ^user_id and w.working_start <= ^working_start)
    |> Repo.all()
  end

  def get_working_times_by_user_and_end(working_end, user_id) do
    from(w in WorkingTime, where: w.user_id == ^user_id and w.working_end <= ^working_end)
    |> Repo.all()
  end

  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time!(123)
      %WorkingTime{}

      iex> get_working_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time!(id), do: Repo.get!(WorkingTime, id)

  def get_one_working_time!(id, user_id) do
    from(w in WorkingTime, where: w.user_id == ^user_id and w.id == ^id)
    |> Repo.all()
  end
  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end
end
