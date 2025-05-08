defmodule RentalProperty.NOTIFICATIONS.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    belongs_to :nofitication_type, Notification_type, foreign_key: :type_id, type: :id
  
    belongs_to :client, Client, foreign_key: :client_id, type: :id
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:description, :type_id, :client_id])
    |> validate_required([:description, :type_id, :client_id])
  end
end
