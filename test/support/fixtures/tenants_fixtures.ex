defmodule RentalProperty.TENANTSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.TENANTS` context.
  """

  @doc """
  Generate a tenant.
  """
  def tenant_fixture(attrs \\ %{}) do
    {:ok, tenant} =
      attrs
      |> Enum.into(%{
        client: "some client",
        property: "some property"
      })
      |> RentalProperty.TENANTS.create_tenant()

    tenant
  end
end
