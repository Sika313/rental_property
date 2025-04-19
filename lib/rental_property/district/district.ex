defmodule RentalProperty.DISTRICT.District do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentalProperty.PROVINCES.Province

  schema "districts" do
    belongs_to :province, Province, foreign_key: :province_id, type: :id
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(district, attrs) do
    district
    |> cast(attrs, [:name, :province_id])
    |> validate_required([:name, :province_id])
  end
end
