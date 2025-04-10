defmodule RentalPropertyWeb.LoginLive do
  use RentalPropertyWeb, :live_view

  alias RentalProperty.CLIENTS

  def mount(_params, session, socket) do
    {:ok, socket}
  end

  def handle_event("login", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    result = case CLIENTS.find_by_phone_and_password(params) do
      {:ok, result} ->
        socket = socket
        |> put_flash(:info, "Logged in successfully.")
        |> redirect(to: "/client/landing_page")
        {:noreply, socket}
      {:error} ->
        socket = socket
        |> put_flash(:error, "Credentials incorrect.")
        {:noreply, socket}
    end
    result
  end

end
