defmodule RentalProperty.Repo.Migrations.AddClientTypeToPropertyType do
  use Ecto.Migration

  def change do
    alter table(:types) do
      add :client_type, :integer
    end
  end
end
