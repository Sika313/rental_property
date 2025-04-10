defmodule RentalProperty.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :fname, :string
      add :lname, :string
      add :gender, :string
      add :phone, :string
      add :password, :string
      add :token, :string
      add :tenant, :boolean
      add :due_date, :date

      add :tier_id, references(:tiers, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
