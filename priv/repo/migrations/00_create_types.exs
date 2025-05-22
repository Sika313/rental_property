defmodule RentalProperty.Repo.Migrations.CreateTypes do
  use Ecto.Migration

  def change do
    create table(:types) do
      add :property_type, :string

      timestamps(type: :utc_datetime)
    end
  end
end
