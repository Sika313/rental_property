defmodule RentalProperty.NOTIFICATION_TYPES.Notification_type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notification_types" do
    field :description, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(notification_type, attrs) do
    notification_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
