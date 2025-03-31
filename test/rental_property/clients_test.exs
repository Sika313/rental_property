defmodule RentalProperty.CLIENTSTest do
  use RentalProperty.DataCase

  alias RentalProperty.CLIENTS

  describe "clients" do
    alias RentalProperty.CLIENTS.Client

    import RentalProperty.CLIENTSFixtures

    @invalid_attrs %{fname: nil, gender: nil, lname: nil, password: nil, phone: nil, tier: nil, token: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert CLIENTS.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert CLIENTS.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{fname: "some fname", gender: "some gender", lname: "some lname", password: "some password", phone: "some phone", tier: "some tier", token: "some token"}

      assert {:ok, %Client{} = client} = CLIENTS.create_client(valid_attrs)
      assert client.fname == "some fname"
      assert client.gender == "some gender"
      assert client.lname == "some lname"
      assert client.password == "some password"
      assert client.phone == "some phone"
      assert client.tier == "some tier"
      assert client.token == "some token"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CLIENTS.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{fname: "some updated fname", gender: "some updated gender", lname: "some updated lname", password: "some updated password", phone: "some updated phone", tier: "some updated tier", token: "some updated token"}

      assert {:ok, %Client{} = client} = CLIENTS.update_client(client, update_attrs)
      assert client.fname == "some updated fname"
      assert client.gender == "some updated gender"
      assert client.lname == "some updated lname"
      assert client.password == "some updated password"
      assert client.phone == "some updated phone"
      assert client.tier == "some updated tier"
      assert client.token == "some updated token"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = CLIENTS.update_client(client, @invalid_attrs)
      assert client == CLIENTS.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = CLIENTS.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> CLIENTS.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = CLIENTS.change_client(client)
    end
  end
end
