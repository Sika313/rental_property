defmodule RentalProperty.TENANTSTest do
  use RentalProperty.DataCase

  alias RentalProperty.TENANTS

  describe "tenants" do
    alias RentalProperty.TENANTS.Tenant

    import RentalProperty.TENANTSFixtures

    @invalid_attrs %{client: nil, property: nil}

    test "list_tenants/0 returns all tenants" do
      tenant = tenant_fixture()
      assert TENANTS.list_tenants() == [tenant]
    end

    test "get_tenant!/1 returns the tenant with given id" do
      tenant = tenant_fixture()
      assert TENANTS.get_tenant!(tenant.id) == tenant
    end

    test "create_tenant/1 with valid data creates a tenant" do
      valid_attrs = %{client: "some client", property: "some property"}

      assert {:ok, %Tenant{} = tenant} = TENANTS.create_tenant(valid_attrs)
      assert tenant.client == "some client"
      assert tenant.property == "some property"
    end

    test "create_tenant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TENANTS.create_tenant(@invalid_attrs)
    end

    test "update_tenant/2 with valid data updates the tenant" do
      tenant = tenant_fixture()
      update_attrs = %{client: "some updated client", property: "some updated property"}

      assert {:ok, %Tenant{} = tenant} = TENANTS.update_tenant(tenant, update_attrs)
      assert tenant.client == "some updated client"
      assert tenant.property == "some updated property"
    end

    test "update_tenant/2 with invalid data returns error changeset" do
      tenant = tenant_fixture()
      assert {:error, %Ecto.Changeset{}} = TENANTS.update_tenant(tenant, @invalid_attrs)
      assert tenant == TENANTS.get_tenant!(tenant.id)
    end

    test "delete_tenant/1 deletes the tenant" do
      tenant = tenant_fixture()
      assert {:ok, %Tenant{}} = TENANTS.delete_tenant(tenant)
      assert_raise Ecto.NoResultsError, fn -> TENANTS.get_tenant!(tenant.id) end
    end

    test "change_tenant/1 returns a tenant changeset" do
      tenant = tenant_fixture()
      assert %Ecto.Changeset{} = TENANTS.change_tenant(tenant)
    end
  end
end
