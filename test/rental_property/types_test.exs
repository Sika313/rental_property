defmodule RentalProperty.TYPESTest do
  use RentalProperty.DataCase

  alias RentalProperty.TYPES

  describe "types" do
    alias RentalProperty.TYPES.Type

    import RentalProperty.TYPESFixtures

    @invalid_attrs %{property_type: nil}

    test "list_types/0 returns all types" do
      type = type_fixture()
      assert TYPES.list_types() == [type]
    end

    test "get_type!/1 returns the type with given id" do
      type = type_fixture()
      assert TYPES.get_type!(type.id) == type
    end

    test "create_type/1 with valid data creates a type" do
      valid_attrs = %{property_type: "some property_type"}

      assert {:ok, %Type{} = type} = TYPES.create_type(valid_attrs)
      assert type.property_type == "some property_type"
    end

    test "create_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TYPES.create_type(@invalid_attrs)
    end

    test "update_type/2 with valid data updates the type" do
      type = type_fixture()
      update_attrs = %{property_type: "some updated property_type"}

      assert {:ok, %Type{} = type} = TYPES.update_type(type, update_attrs)
      assert type.property_type == "some updated property_type"
    end

    test "update_type/2 with invalid data returns error changeset" do
      type = type_fixture()
      assert {:error, %Ecto.Changeset{}} = TYPES.update_type(type, @invalid_attrs)
      assert type == TYPES.get_type!(type.id)
    end

    test "delete_type/1 deletes the type" do
      type = type_fixture()
      assert {:ok, %Type{}} = TYPES.delete_type(type)
      assert_raise Ecto.NoResultsError, fn -> TYPES.get_type!(type.id) end
    end

    test "change_type/1 returns a type changeset" do
      type = type_fixture()
      assert %Ecto.Changeset{} = TYPES.change_type(type)
    end
  end
end
