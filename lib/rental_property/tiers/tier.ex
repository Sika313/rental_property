defmodule RentalProperty.TIERS.Tier do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentalProperty.CLIENTS.Client

  schema "tiers" do
    field :type, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tier, attrs) do
    tier
    |> cast(attrs, [:type])
    |> validate_required([:type])
  end
end
