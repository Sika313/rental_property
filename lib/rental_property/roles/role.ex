defmodule RentalProperty.ROLES.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field :description, :string
    field :name, :string
    field :permissions, {:array, :string} 

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :description, :permissions])
    |> validate_required([:name, :description, :permissions])
  end
end
