defmodule RentalProperty.TYPES.Type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "types" do
    field :property_type, :string
    field :client_type, :integer


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:property_type, :client_type])
    |> validate_required([:property_type, :client_type])
  end
end
