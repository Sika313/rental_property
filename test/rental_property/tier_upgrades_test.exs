defmodule RentalProperty.TIER_UPGRADESTest do
  use RentalProperty.DataCase

  alias RentalProperty.TIER_UPGRADES

  describe "tier_upgrades" do
    alias RentalProperty.TIER_UPGRADES.Tier_upgrade

    import RentalProperty.TIER_UPGRADESFixtures

    @invalid_attrs %{status: nil}

    test "list_tier_upgrades/0 returns all tier_upgrades" do
      tier_upgrade = tier_upgrade_fixture()
      assert TIER_UPGRADES.list_tier_upgrades() == [tier_upgrade]
    end

    test "get_tier_upgrade!/1 returns the tier_upgrade with given id" do
      tier_upgrade = tier_upgrade_fixture()
      assert TIER_UPGRADES.get_tier_upgrade!(tier_upgrade.id) == tier_upgrade
    end

    test "create_tier_upgrade/1 with valid data creates a tier_upgrade" do
      valid_attrs = %{status: "some status"}

      assert {:ok, %Tier_upgrade{} = tier_upgrade} = TIER_UPGRADES.create_tier_upgrade(valid_attrs)
      assert tier_upgrade.status == "some status"
    end

    test "create_tier_upgrade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TIER_UPGRADES.create_tier_upgrade(@invalid_attrs)
    end

    test "update_tier_upgrade/2 with valid data updates the tier_upgrade" do
      tier_upgrade = tier_upgrade_fixture()
      update_attrs = %{status: "some updated status"}

      assert {:ok, %Tier_upgrade{} = tier_upgrade} = TIER_UPGRADES.update_tier_upgrade(tier_upgrade, update_attrs)
      assert tier_upgrade.status == "some updated status"
    end

    test "update_tier_upgrade/2 with invalid data returns error changeset" do
      tier_upgrade = tier_upgrade_fixture()
      assert {:error, %Ecto.Changeset{}} = TIER_UPGRADES.update_tier_upgrade(tier_upgrade, @invalid_attrs)
      assert tier_upgrade == TIER_UPGRADES.get_tier_upgrade!(tier_upgrade.id)
    end

    test "delete_tier_upgrade/1 deletes the tier_upgrade" do
      tier_upgrade = tier_upgrade_fixture()
      assert {:ok, %Tier_upgrade{}} = TIER_UPGRADES.delete_tier_upgrade(tier_upgrade)
      assert_raise Ecto.NoResultsError, fn -> TIER_UPGRADES.get_tier_upgrade!(tier_upgrade.id) end
    end

    test "change_tier_upgrade/1 returns a tier_upgrade changeset" do
      tier_upgrade = tier_upgrade_fixture()
      assert %Ecto.Changeset{} = TIER_UPGRADES.change_tier_upgrade(tier_upgrade)
    end
  end
end
