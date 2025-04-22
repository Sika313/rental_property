defmodule RentalProperty.USERSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.USERS` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        fname: "some fname",
        gender: "some gender",
        lname: "some lname",
        password: "some password",
        phone: "some phone"
      })
      |> RentalProperty.USERS.create_user()

    user
  end
end
