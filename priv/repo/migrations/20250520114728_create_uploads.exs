defmodule RentalProperty.Repo.Migrations.CreateUploads do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :name, :string
      add :file_path, :string

      add :client_id, references(:clients, column: :id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
