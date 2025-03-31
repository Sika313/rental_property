defmodule RentalProperty.LOGS.Log do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logs" do
    belongs_to :client, Client, foreign_key: :client_id, type: :id
    field :device, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:client_id, :device])
    |> validate_required([:client_id, :device])
  end
end
