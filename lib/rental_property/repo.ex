defmodule RentalProperty.Repo do
  use Ecto.Repo,
    otp_app: :rental_property,
    adapter: Ecto.Adapters.Postgres
end
