defmodule RentalProperty.NOTIFICATION_TYPESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.NOTIFICATION_TYPES` context.
  """

  @doc """
  Generate a notification_type.
  """
  def notification_type_fixture(attrs \\ %{}) do
    {:ok, notification_type} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> RentalProperty.NOTIFICATION_TYPES.create_notification_type()

    notification_type
  end
end
