defmodule RentalProperty.Repo.Migrations.CreateProperties do
  use Ecto.Migration

  def change do
    create table(:properties) do
      add :number_of_rooms, :string
      add :location, :string
      add :description, :string
      add :price, :string
      add :occupied, :boolean, default: false, null: false
      add :image_one, :string
      add :image_two, :string
      add :image_three, :string
      add :image_four, :string

      add :client_id, references(:clients, column: :id, on_delete: :nothing) 
      add :type_id, references(:types, column: :id, on_delete: :nothing)
      add :province_id, references(:provinces, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
