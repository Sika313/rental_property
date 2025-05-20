defmodule RentalProperty.TYPES.Type do
  use Ecto.Schema
 users import Ecto.Changeset

  schema "types" do
    field :property_type, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:property_type])
    |> validate_required([:property_type])
  end
end
