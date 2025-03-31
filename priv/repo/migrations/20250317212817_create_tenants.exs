defmodule RentalProperty.Repo.Migrations.CreateTenants do
  use Ecto.Migration

  def change do
    create table(:tenants) do
      add :client_id, references(:clients, column: :id, on_delete: :nothing)
      add :property_id, references(:properties, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
