defmodule RentalProperty.TIERSTest do
  use RentalProperty.DataCase

  alias RentalProperty.TIERS

  describe "tiers" do
    alias RentalProperty.TIERS.Tier

    import RentalProperty.TIERSFixtures

    @invalid_attrs %{type: nil}

    test "list_tiers/0 returns all tiers" do
      tier = tier_fixture()
      assert TIERS.list_tiers() == [tier]
    end

    test "get_tier!/1 returns the tier with given id" do
      tier = tier_fixture()
      assert TIERS.get_tier!(tier.id) == tier
    end

    test "create_tier/1 with valid data creates a tier" do
      valid_attrs = %{type: "some type"}

      assert {:ok, %Tier{} = tier} = TIERS.create_tier(valid_attrs)
      assert tier.type == "some type"
    end

    test "create_tier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TIERS.create_tier(@invalid_attrs)
    end

    test "update_tier/2 with valid data updates the tier" do
      tier = tier_fixture()
      update_attrs = %{type: "some updated type"}

      assert {:ok, %Tier{} = tier} = TIERS.update_tier(tier, update_attrs)
      assert tier.type == "some updated type"
    end

    test "update_tier/2 with invalid data returns error changeset" do
      tier = tier_fixture()
      assert {:error, %Ecto.Changeset{}} = TIERS.update_tier(tier, @invalid_attrs)
      assert tier == TIERS.get_tier!(tier.id)
    end

    test "delete_tier/1 deletes the tier" do
      tier = tier_fixture()
      assert {:ok, %Tier{}} = TIERS.delete_tier(tier)
      assert_raise Ecto.NoResultsError, fn -> TIERS.get_tier!(tier.id) end
    end

    test "change_tier/1 returns a tier changeset" do
      tier = tier_fixture()
      assert %Ecto.Changeset{} = TIERS.change_tier(tier)
    end
  end
end
