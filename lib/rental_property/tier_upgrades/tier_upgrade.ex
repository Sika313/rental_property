defmodule RentalProperty.TIER_UPGRADES.Tier_upgrade do
  use Ecto.Schema
  import Ecto.Changeset
  

  schema "tier_upgrades" do
    belongs_to :client, Client, foreign_key: :client_id, type: :id
    belongs_to :tire, Tier, foreign_key: :tier_id, type: :id
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tier_upgrade, attrs) do
    tier_upgrade
    |> cast(attrs, [:status, :client_id, :tier_id])
    |> validate_required([:status, :client_id, :tier_id])
  end
end
