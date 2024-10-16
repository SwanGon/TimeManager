defmodule Timemanager.RoleManagerTest do
  use Timemanager.DataCase

  alias Timemanager.RoleManager

  describe "roles" do
    alias Timemanager.RoleManager.Role

    import Timemanager.RoleManagerFixtures

    @invalid_attrs %{title: nil}

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert RoleManager.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert RoleManager.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Role{} = role} = RoleManager.create_role(valid_attrs)
      assert role.title == "some title"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RoleManager.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Role{} = role} = RoleManager.update_role(role, update_attrs)
      assert role.title == "some updated title"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = RoleManager.update_role(role, @invalid_attrs)
      assert role == RoleManager.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = RoleManager.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> RoleManager.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = RoleManager.change_role(role)
    end
  end
end
