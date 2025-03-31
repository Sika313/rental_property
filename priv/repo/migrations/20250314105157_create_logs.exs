defmodule RentalProperty.Repo.Migrations.CreateLogs do
  use Ecto.Migration

  def change do
    create table(:logs) do
      add :device, :string

      add :client_id, references(:clients, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
