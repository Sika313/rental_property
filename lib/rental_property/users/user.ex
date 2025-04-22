defmodule RentalProperty.USERS.User do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias RentalProperty.ROLES.Role

  schema "users" do
    belongs_to :role, Role, foreign_key: :role_id, type: :id
    field :fname, :string
    field :gender, :string
    field :lname, :string
    field :password, :string
    field :phone, :string
    field :token, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:fname, :lname, :gender, :phone, :password, :role_id, :token])
    |> validate_required([:fname, :lname, :gender, :phone, :password, :role_id, :token])
  end
end
