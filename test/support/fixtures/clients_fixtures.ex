defmodule RentalProperty.CLIENTSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.CLIENTS` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        fname: "some fname",
        gender: "some gender",
        lname: "some lname",
        password: "some password",
        phone: "some phone",
        tier: "some tier",
        token: "some token"
      })
      |> RentalProperty.CLIENTS.create_client()

    client
  end
end
