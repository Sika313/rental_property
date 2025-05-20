defmodule RentalProperty.UPLOADSTest do
  use RentalProperty.DataCase

  alias RentalProperty.UPLOADS

  describe "uploads" do
    alias RentalProperty.UPLOADS.Upload

    import RentalProperty.UPLOADSFixtures

    @invalid_attrs %{name: nil}

    test "list_uploads/0 returns all uploads" do
      upload = upload_fixture()
      assert UPLOADS.list_uploads() == [upload]
    end

    test "get_upload!/1 returns the upload with given id" do
      upload = upload_fixture()
      assert UPLOADS.get_upload!(upload.id) == upload
    end

    test "create_upload/1 with valid data creates a upload" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Upload{} = upload} = UPLOADS.create_upload(valid_attrs)
      assert upload.name == "some name"
    end

    test "create_upload/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UPLOADS.create_upload(@invalid_attrs)
    end

    test "update_upload/2 with valid data updates the upload" do
      upload = upload_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Upload{} = upload} = UPLOADS.update_upload(upload, update_attrs)
      assert upload.name == "some updated name"
    end

    test "update_upload/2 with invalid data returns error changeset" do
      upload = upload_fixture()
      assert {:error, %Ecto.Changeset{}} = UPLOADS.update_upload(upload, @invalid_attrs)
      assert upload == UPLOADS.get_upload!(upload.id)
    end

    test "delete_upload/1 deletes the upload" do
      upload = upload_fixture()
      assert {:ok, %Upload{}} = UPLOADS.delete_upload(upload)
      assert_raise Ecto.NoResultsError, fn -> UPLOADS.get_upload!(upload.id) end
    end

    test "change_upload/1 returns a upload changeset" do
      upload = upload_fixture()
      assert %Ecto.Changeset{} = UPLOADS.change_upload(upload)
    end
  end
end
