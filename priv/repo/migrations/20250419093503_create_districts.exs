defmodule RentalProperty.Repo.Migrations.CreateDistricts do
  use Ecto.Migration

  def change do
    create table(:districts) do
      add :name, :string

      add :province_id, references(:provinces, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
