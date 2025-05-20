defmodule RentalPropertyWeb.UpgradeTierLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.CLIENTS
  alias RentalProperty.NOTIFICATIONS
  alias RentalProperty.NOTIFICATION_TYPES

  def mount(_params, session, socket) do
    notification_types =  NOTIFICATION_TYPES.list_notification_types() 

    notification_types = for nt <- notification_types do
      Map.from_struct(nt)
    end
    notification_msg = Enum.at(notification_types, 0)
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
        |> assign(:notification_msg, notification_msg)

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
      description: socket.assigns.notification_msg.description 
    }
    NOTIFICATIONS.create_notification(notification) 
    socket = socket
    |> put_flash(:info, "Payment successful.")
    |> redirect(to: "/client/landing_page")
    {:noreply, socket}
  end
  
end
