defmodule RentalProperty.UPLOADS.Upload do
  use Ecto.Schema
  import Ecto.Changeset

  schema "uploads" do
    belongs_to :client, Client, foreign_key: :client_id, type: :id
    field :name, :string
    field :file_path, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:name, :client_id, :file_path])
    |> validate_required([:name, :client_id, :file_path])
  end
end
