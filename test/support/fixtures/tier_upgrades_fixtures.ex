defmodule RentalProperty.TIER_UPGRADESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.TIER_UPGRADES` context.
  """

  @doc """
  Generate a tier_upgrade.
  """
  def tier_upgrade_fixture(attrs \\ %{}) do
    {:ok, tier_upgrade} =
      attrs
      |> Enum.into(%{
        status: "some status"
      })
      |> RentalProperty.TIER_UPGRADES.create_tier_upgrade()

    tier_upgrade
  end
end
