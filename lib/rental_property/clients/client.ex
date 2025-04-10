defmodule RentalProperty.CLIENTS.Client do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentalProperty.PROPERTIES.Property
  alias RentalProperty.LOGS.Log
  alias RentalProperty.TENANTS.Tenant
  schema "clients" do
    belongs_to :tier, Tier, foreign_key: :tier_id, type: :id
    field :fname, :string
    field :gender, :string
    field :lname, :string
    field :password, :string
    field :phone, :string
    field :token, :string
    field :tenant, :boolean
    field :due_date, :date 

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:fname, :lname, :gender, :phone, :password, :tier_id, :token, :tenant, :due_date])
    |> validate_required([:fname, :lname, :gender, :phone, :password, :tier_id, :token, :tenant, :due_date])
  end
end
