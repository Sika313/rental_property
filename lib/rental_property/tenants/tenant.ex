defmodule RentalProperty.TENANTS.Tenant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tenants" do
    belongs_to :client, Client, foreign_key: :client_id, type: :id
    belongs_to :property, Property, foreign_key: :property_id, type: :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tenant, attrs) do
    tenant
    |> cast(attrs, [:client_id, :property_id])
    |> validate_required([:property, :property_id])
  end
end
