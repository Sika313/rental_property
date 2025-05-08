defmodule RentalProperty.NOTIFICATIONSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.NOTIFICATIONS` context.
  """

  @doc """
  Generate a notification.
  """
  def notification_fixture(attrs \\ %{}) do
    {:ok, notification} =
      attrs
      |> Enum.into(%{
        description: "some description"
      })
      |> RentalProperty.NOTIFICATIONS.create_notification()

    notification
  end
end
