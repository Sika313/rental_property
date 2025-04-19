defmodule RentalProperty.PROVINCESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.PROVINCES` context.
  """

  @doc """
  Generate a province.
  """
  def province_fixture(attrs \\ %{}) do
    {:ok, province} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> RentalProperty.PROVINCES.create_province()

    province
  end
end
