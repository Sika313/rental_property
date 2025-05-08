defmodule RentalProperty.NOTIFICATIONSTest do
  use RentalProperty.DataCase

  alias RentalProperty.NOTIFICATIONS

  describe "notifications" do
    alias RentalProperty.NOTIFICATIONS.Notification

    import RentalProperty.NOTIFICATIONSFixtures

    @invalid_attrs %{description: nil}

    test "list_notifications/0 returns all notifications" do
      notification = notification_fixture()
      assert NOTIFICATIONS.list_notifications() == [notification]
    end

    test "get_notification!/1 returns the notification with given id" do
      notification = notification_fixture()
      assert NOTIFICATIONS.get_notification!(notification.id) == notification
    end

    test "create_notification/1 with valid data creates a notification" do
      valid_attrs = %{description: "some description"}

      assert {:ok, %Notification{} = notification} = NOTIFICATIONS.create_notification(valid_attrs)
      assert notification.description == "some description"
    end

    test "create_notification/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NOTIFICATIONS.create_notification(@invalid_attrs)
    end

    test "update_notification/2 with valid data updates the notification" do
      notification = notification_fixture()
      update_attrs = %{description: "some updated description"}

      assert {:ok, %Notification{} = notification} = NOTIFICATIONS.update_notification(notification, update_attrs)
      assert notification.description == "some updated description"
    end

    test "update_notification/2 with invalid data returns error changeset" do
      notification = notification_fixture()
      assert {:error, %Ecto.Changeset{}} = NOTIFICATIONS.update_notification(notification, @invalid_attrs)
      assert notification == NOTIFICATIONS.get_notification!(notification.id)
    end

    test "delete_notification/1 deletes the notification" do
      notification = notification_fixture()
      assert {:ok, %Notification{}} = NOTIFICATIONS.delete_notification(notification)
      assert_raise Ecto.NoResultsError, fn -> NOTIFICATIONS.get_notification!(notification.id) end
    end

    test "change_notification/1 returns a notification changeset" do
      notification = notification_fixture()
      assert %Ecto.Changeset{} = NOTIFICATIONS.change_notification(notification)
    end
  end
end
