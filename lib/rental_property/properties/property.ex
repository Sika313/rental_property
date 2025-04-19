defmodule RentalProperty.PROPERTIES.Property do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentalProperty.TENANTS.Tenant

  schema "properties" do
    belongs_to :client, Client, foreign_key: :client_id, type: :id
    belongs_to :type, Type, foreign_key: :type_id, type: :id
    belongs_to :province, Province, foreign_key: :province_id, type: :id
    field :description, :string
    field :image_four, :string
    field :image_one, :string
    field :image_three, :string
    field :image_two, :string
    field :location, :string
    field :number_of_rooms, :string
    field :occupied, :boolean, default: false
    field :price, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:number_of_rooms, :location, :description, :price, :client_id, :occupied, :image_one, :image_two, :image_three, :image_four, :type_id, :province_id])
    |> validate_required([:number_of_rooms, :location, :description, :price, :client_id, :occupied, :image_one, :image_two, :image_three, :image_four, :type_id, :province_id])
  end
end
