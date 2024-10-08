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
      valid_attrs = %{start: ~U[2024-10-07 11:50:00Z], end: ~U[2024-10-07 11:50:00Z]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimeManager.create_working_time(valid_attrs)
      assert working_time.start == ~U[2024-10-07 11:50:00Z]
      assert working_time.end == ~U[2024-10-07 11:50:00Z]
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WorkingTimeManager.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{start: ~U[2024-10-08 11:50:00Z], end: ~U[2024-10-08 11:50:00Z]}

      assert {:ok, %WorkingTime{} = working_time} = WorkingTimeManager.update_working_time(working_time, update_attrs)
      assert working_time.start == ~U[2024-10-08 11:50:00Z]
      assert working_time.end == ~U[2024-10-08 11:50:00Z]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = WorkingTimeManager.update_working_time(working_time, @invalid_attrs)
      assert working_time == WorkingTimeManager.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = WorkingTimeManager.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> WorkingTimeManager.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = WorkingTimeManager.change_working_time(working_time)
    end
  end
end
