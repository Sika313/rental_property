defmodule RentalProperty.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :description, :string

      add :type_id, references(:notification_types, column: :id, on_delete: :nothing)
      add :client_id, references(:clients, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
