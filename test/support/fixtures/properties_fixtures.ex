defmodule RentalProperty.PROPERTIESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.PROPERTIES` context.
  """

  @doc """
  Generate a property.
  """
  def property_fixture(attrs \\ %{}) do
    {:ok, property} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_four: "some image_four",
        image_one: "some image_one",
        image_three: "some image_three",
        image_two: "some image_two",
        location: "some location",
        number_of_rooms: "some number_of_rooms",
        occupied: true,
        owner: 42,
        price: "some price"
      })
      |> RentalProperty.PROPERTIES.create_property()

    property
  end
end
