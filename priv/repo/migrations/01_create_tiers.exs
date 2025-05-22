defmodule RentalProperty.Repo.Migrations.CreateTiers do
  use Ecto.Migration

  def change do
    create table(:tiers) do
      add :type, :string

      timestamps(type: :utc_datetime)
    end
  end
end
