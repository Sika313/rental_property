defmodule RentalProperty.USERSTest do
  use RentalProperty.DataCase

  alias RentalProperty.USERS

  describe "users" do
    alias RentalProperty.USERS.User

    import RentalProperty.USERSFixtures

    @invalid_attrs %{fname: nil, gender: nil, lname: nil, password: nil, phone: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert USERS.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert USERS.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{fname: "some fname", gender: "some gender", lname: "some lname", password: "some password", phone: "some phone"}

      assert {:ok, %User{} = user} = USERS.create_user(valid_attrs)
      assert user.fname == "some fname"
      assert user.gender == "some gender"
      assert user.lname == "some lname"
      assert user.password == "some password"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = USERS.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{fname: "some updated fname", gender: "some updated gender", lname: "some updated lname", password: "some updated password", phone: "some updated phone"}

      assert {:ok, %User{} = user} = USERS.update_user(user, update_attrs)
      assert user.fname == "some updated fname"
      assert user.gender == "some updated gender"
      assert user.lname == "some updated lname"
      assert user.password == "some updated password"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = USERS.update_user(user, @invalid_attrs)
      assert user == USERS.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = USERS.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> USERS.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = USERS.change_user(user)
    end
  end
end
