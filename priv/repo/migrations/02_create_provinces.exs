defmodule RentalProperty.Repo.Migrations.CreateProvinces do
  use Ecto.Migration

  def change do
    create table(:provinces) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
