defmodule RentalProperty.UPLOADSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RentalProperty.UPLOADS` context.
  """

  @doc """
  Generate a upload.
  """
  def upload_fixture(attrs \\ %{}) do
    {:ok, upload} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> RentalProperty.UPLOADS.create_upload()

    upload
  end
end
