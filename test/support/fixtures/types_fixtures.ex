defmodule RentalProperty.TYPESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.TYPES` context.
  """

  @doc """
  Generate a type.
  """
  def type_fixture(attrs \\ %{}) do
    {:ok, type} =
      attrs
      |> Enum.into(%{
        property_type: "some property_type"
      })
      |> RentalProperty.TYPES.create_type()

    type
  end
end
