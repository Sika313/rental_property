defmodule RentalProperty.PROPERTIESTest do
  use RentalProperty.DataCase

  alias RentalProperty.PROPERTIES

  describe "properties" do
    alias RentalProperty.PROPERTIES.Property

    import RentalProperty.PROPERTIESFixtures

    @invalid_attrs %{description: nil, image_four: nil, image_one: nil, image_three: nil, image_two: nil, location: nil, number_of_rooms: nil, occupied: nil, owner: nil, price: nil}

    test "list_properties/0 returns all properties" do
      property = property_fixture()
      assert PROPERTIES.list_properties() == [property]
    end

    test "get_property!/1 returns the property with given id" do
      property = property_fixture()
      assert PROPERTIES.get_property!(property.id) == property
    end

    test "create_property/1 with valid data creates a property" do
      valid_attrs = %{description: "some description", image_four: "some image_four", image_one: "some image_one", image_three: "some image_three", image_two: "some image_two", location: "some location", number_of_rooms: "some number_of_rooms", occupied: true, owner: 42, price: "some price"}

      assert {:ok, %Property{} = property} = PROPERTIES.create_property(valid_attrs)
      assert property.description == "some description"
      assert property.image_four == "some image_four"
      assert property.image_one == "some image_one"
      assert property.image_three == "some image_three"
      assert property.image_two == "some image_two"
      assert property.location == "some location"
      assert property.number_of_rooms == "some number_of_rooms"
      assert property.occupied == true
      assert property.owner == 42
      assert property.price == "some price"
    end

    test "create_property/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PROPERTIES.create_property(@invalid_attrs)
    end

    test "update_property/2 with valid data updates the property" do
      property = property_fixture()
      update_attrs = %{description: "some updated description", image_four: "some updated image_four", image_one: "some updated image_one", image_three: "some updated image_three", image_two: "some updated image_two", location: "some updated location", number_of_rooms: "some updated number_of_rooms", occupied: false, owner: 43, price: "some updated price"}

      assert {:ok, %Property{} = property} = PROPERTIES.update_property(property, update_attrs)
      assert property.description == "some updated description"
      assert property.image_four == "some updated image_four"
      assert property.image_one == "some updated image_one"
      assert property.image_three == "some updated image_three"
      assert property.image_two == "some updated image_two"
      assert property.location == "some updated location"
      assert property.number_of_rooms == "some updated number_of_rooms"
      assert property.occupied == false
      assert property.owner == 43
      assert property.price == "some updated price"
    end

    test "update_property/2 with invalid data returns error changeset" do
      property = property_fixture()
      assert {:error, %Ecto.Changeset{}} = PROPERTIES.update_property(property, @invalid_attrs)
      assert property == PROPERTIES.get_property!(property.id)
    end

    test "delete_property/1 deletes the property" do
      property = property_fixture()
      assert {:ok, %Property{}} = PROPERTIES.delete_property(property)
      assert_raise Ecto.NoResultsError, fn -> PROPERTIES.get_property!(property.id) end
    end

    test "change_property/1 returns a property changeset" do
      property = property_fixture()
      assert %Ecto.Changeset{} = PROPERTIES.change_property(property)
    end
  end
end
