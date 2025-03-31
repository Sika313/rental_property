defmodule RentalProperty.LOGSTest do
  use RentalProperty.DataCase

  alias RentalProperty.LOGS

  describe "logs" do
    alias RentalProperty.LOGS.Log

    import RentalProperty.LOGSFixtures

    @invalid_attrs %{client_id: nil, device: nil}

    test "list_logs/0 returns all logs" do
      log = log_fixture()
      assert LOGS.list_logs() == [log]
    end

    test "get_log!/1 returns the log with given id" do
      log = log_fixture()
      assert LOGS.get_log!(log.id) == log
    end

    test "create_log/1 with valid data creates a log" do
      valid_attrs = %{client_id: 42, device: "some device"}

      assert {:ok, %Log{} = log} = LOGS.create_log(valid_attrs)
      assert log.client_id == 42
      assert log.device == "some device"
    end

    test "create_log/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LOGS.create_log(@invalid_attrs)
    end

    test "update_log/2 with valid data updates the log" do
      log = log_fixture()
      update_attrs = %{client_id: 43, device: "some updated device"}

      assert {:ok, %Log{} = log} = LOGS.update_log(log, update_attrs)
      assert log.client_id == 43
      assert log.device == "some updated device"
    end

    test "update_log/2 with invalid data returns error changeset" do
      log = log_fixture()
      assert {:error, %Ecto.Changeset{}} = LOGS.update_log(log, @invalid_attrs)
      assert log == LOGS.get_log!(log.id)
    end

    test "delete_log/1 deletes the log" do
      log = log_fixture()
      assert {:ok, %Log{}} = LOGS.delete_log(log)
      assert_raise Ecto.NoResultsError, fn -> LOGS.get_log!(log.id) end
    end

    test "change_log/1 returns a log changeset" do
      log = log_fixture()
      assert %Ecto.Changeset{} = LOGS.change_log(log)
    end
  end
end
