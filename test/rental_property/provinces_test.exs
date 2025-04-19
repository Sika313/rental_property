defmodule RentalProperty.PROVINCESTest do
  use RentalProperty.DataCase

  alias RentalProperty.PROVINCES

  describe "provinces" do
    alias RentalProperty.PROVINCES.Province

    import RentalProperty.PROVINCESFixtures

    @invalid_attrs %{name: nil}

    test "list_provinces/0 returns all provinces" do
      province = province_fixture()
      assert PROVINCES.list_provinces() == [province]
    end

    test "get_province!/1 returns the province with given id" do
      province = province_fixture()
      assert PROVINCES.get_province!(province.id) == province
    end

    test "create_province/1 with valid data creates a province" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Province{} = province} = PROVINCES.create_province(valid_attrs)
      assert province.name == "some name"
    end

    test "create_province/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PROVINCES.create_province(@invalid_attrs)
    end

    test "update_province/2 with valid data updates the province" do
      province = province_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Province{} = province} = PROVINCES.update_province(province, update_attrs)
      assert province.name == "some updated name"
    end

    test "update_province/2 with invalid data returns error changeset" do
      province = province_fixture()
      assert {:error, %Ecto.Changeset{}} = PROVINCES.update_province(province, @invalid_attrs)
      assert province == PROVINCES.get_province!(province.id)
    end

    test "delete_province/1 deletes the province" do
      province = province_fixture()
      assert {:ok, %Province{}} = PROVINCES.delete_province(province)
      assert_raise Ecto.NoResultsError, fn -> PROVINCES.get_province!(province.id) end
    end

    test "change_province/1 returns a province changeset" do
      province = province_fixture()
      assert %Ecto.Changeset{} = PROVINCES.change_province(province)
    end
  end
end
