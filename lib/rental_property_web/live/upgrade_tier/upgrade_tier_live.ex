defmodule RentalPropertyWeb.UpgradeTierLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.CLIENTS
  alias RentalProperty.NOTIFICATIONS

  def mount(_params, session, socket) do
    result = case CLIENTS.find_by_token(session["token"]) do
      nil ->
        socket = socket
        |> put_flash(:error, "You must login first.")
        |> redirect("/login")
        socket
      result ->
        r = Map.from_struct(result)
        socket = socket
        |> assign(:client, r)
        |> assign(:choice, "House")
        |> assign(:house_price, "K100")

        {:ok, socket}
    end
    result
  end

  def handle_event("house_price", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    socket = socket
    |> assign(:house_price, params["value"])
    {:noreply, socket}
  end

  def handle_event("pay_house", params, socket) do
    notification = %{
      type_id: 1,
      client_id: socket.assigns.client.id,
      description: "Your payment was successful. Your account will be upgraded within 24hrs."
    }
    NOTIFICATIONS.create_notification(notification) 
    IO.inspect(params, label: "PARAMS--->")
    socket = socket
    |> put_flash(:info, "Payment successful.")
    |> redirect(to: "/client/landing_page")
    {:noreply, socket}
  end
  
end
