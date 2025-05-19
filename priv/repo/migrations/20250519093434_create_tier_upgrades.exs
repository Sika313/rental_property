defmodule RentalProperty.Repo.Migrations.CreateTierUpgrades do
  use Ecto.Migration

  def change do
    create table(:tier_upgrades) do
      add :status, :string

      add :client_id, references(:clients, column: :id, on_delete: :nothing)
      add :tier_id, references(:tiers, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
