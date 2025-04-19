defmodule RentalProperty.DISTRICTTest do
  use RentalProperty.DataCase

  alias RentalProperty.DISTRICT

  describe "districts" do
    alias RentalProperty.DISTRICT.District

    import RentalProperty.DISTRICTFixtures

    @invalid_attrs %{name: nil, province: nil}

    test "list_districts/0 returns all districts" do
      district = district_fixture()
      assert DISTRICT.list_districts() == [district]
    end

    test "get_district!/1 returns the district with given id" do
      district = district_fixture()
      assert DISTRICT.get_district!(district.id) == district
    end

    test "create_district/1 with valid data creates a district" do
      valid_attrs = %{name: "some name", province: 42}

      assert {:ok, %District{} = district} = DISTRICT.create_district(valid_attrs)
      assert district.name == "some name"
      assert district.province == 42
    end

    test "create_district/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DISTRICT.create_district(@invalid_attrs)
    end

    test "update_district/2 with valid data updates the district" do
      district = district_fixture()
      update_attrs = %{name: "some updated name", province: 43}

      assert {:ok, %District{} = district} = DISTRICT.update_district(district, update_attrs)
      assert district.name == "some updated name"
      assert district.province == 43
    end

    test "update_district/2 with invalid data returns error changeset" do
      district = district_fixture()
      assert {:error, %Ecto.Changeset{}} = DISTRICT.update_district(district, @invalid_attrs)
      assert district == DISTRICT.get_district!(district.id)
    end

    test "delete_district/1 deletes the district" do
      district = district_fixture()
      assert {:ok, %District{}} = DISTRICT.delete_district(district)
      assert_raise Ecto.NoResultsError, fn -> DISTRICT.get_district!(district.id) end
    end

    test "change_district/1 returns a district changeset" do
      district = district_fixture()
      assert %Ecto.Changeset{} = DISTRICT.change_district(district)
    end
  end
end
