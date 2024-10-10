defmodule Timemanager.WorkingTimeManagerTest do
  use Timemanager.DataCase

  alias Timemanager.WorkingTimeManager

  describe "working_times" do
    alias Timemanager.WorkingTimeManager.WorkingTime

    import Timemanager.WorkingTimeManagerFixtures

    @invalid_attrs %{start: nil, end: nil}

    test "list_working_times/0 returns all working_times" do
      working_time = working_time_fixture()
      assert WorkingTimeManager.list_working_times() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert WorkingTimeManager.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      valid_attrs = %{start: ~U[2024-10-08 09:05:23Z], end: ~U[2024-10-08 17:10:33Z]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimeManager.create_working_time(valid_attrs)
      assert working_time.start == ~U[2024-10-08 09:05:23Z]
      assert working_time.end == ~U[2024-10-08 17:10:33Z]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimeManager.create_working_time(@invalid_attrs)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = WorkingTimeManager.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimeManager.get_working_time!(working_time.id) end
    end
  end
end
