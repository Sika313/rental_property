defmodule RentalProperty.TIERSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.TIERS` context.
  """

  @doc """
  Generate a tier.
  """
  def tier_fixture(attrs \\ %{}) do
    {:ok, tier} =
      attrs
      |> Enum.into(%{
        type: "some type"
      })
      |> RentalProperty.TIERS.create_tier()

    tier
  end
end
