defmodule RentalProperty.NOTIFICATION_TYPESTest do
  use RentalProperty.DataCase

  alias RentalProperty.NOTIFICATION_TYPES

  describe "notification_types" do
    alias RentalProperty.NOTIFICATION_TYPES.Notification_type

    import RentalProperty.NOTIFICATION_TYPESFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_notification_types/0 returns all notification_types" do
      notification_type = notification_type_fixture()
      assert NOTIFICATION_TYPES.list_notification_types() == [notification_type]
    end

    test "get_notification_type!/1 returns the notification_type with given id" do
      notification_type = notification_type_fixture()
      assert NOTIFICATION_TYPES.get_notification_type!(notification_type.id) == notification_type
    end

    test "create_notification_type/1 with valid data creates a notification_type" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Notification_type{} = notification_type} = NOTIFICATION_TYPES.create_notification_type(valid_attrs)
      assert notification_type.description == "some description"
      assert notification_type.name == "some name"
    end

    test "create_notification_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NOTIFICATION_TYPES.create_notification_type(@invalid_attrs)
    end

    test "update_notification_type/2 with valid data updates the notification_type" do
      notification_type = notification_type_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Notification_type{} = notification_type} = NOTIFICATION_TYPES.update_notification_type(notification_type, update_attrs)
      assert notification_type.description == "some updated description"
      assert notification_type.name == "some updated name"
    end

    test "update_notification_type/2 with invalid data returns error changeset" do
      notification_type = notification_type_fixture()
      assert {:error, %Ecto.Changeset{}} = NOTIFICATION_TYPES.update_notification_type(notification_type, @invalid_attrs)
      assert notification_type == NOTIFICATION_TYPES.get_notification_type!(notification_type.id)
    end

    test "delete_notification_type/1 deletes the notification_type" do
      notification_type = notification_type_fixture()
      assert {:ok, %Notification_type{}} = NOTIFICATION_TYPES.delete_notification_type(notification_type)
      assert_raise Ecto.NoResultsError, fn -> NOTIFICATION_TYPES.get_notification_type!(notification_type.id) end
    end

    test "change_notification_type/1 returns a notification_type changeset" do
      notification_type = notification_type_fixture()
      assert %Ecto.Changeset{} = NOTIFICATION_TYPES.change_notification_type(notification_type)
    end
  end
end
