defmodule RentalProperty.LOGSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.LOGS` context.
  """

  @doc """
  Generate a log.
  """
  def log_fixture(attrs \\ %{}) do
    {:ok, log} =
      attrs
      |> Enum.into(%{
        client_id: 42,
        device: "some device"
      })
      |> RentalProperty.LOGS.create_log()

    log
  end
end
