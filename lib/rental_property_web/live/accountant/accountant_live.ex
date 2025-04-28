defmodule RentalPropertyWeb.AccountantLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.ROLES
  alias RentalProperty.USERS
  alias RentalPropertyWeb.ViewClientsComponent

  def mount(_params, session, socket) do
    roles = ROLES.list_roles()
    |> then(fn roles -> for i <- roles do Map.from_struct(i) end end )
    socket = socket
    |> assign(:roles, roles)
    |> assign(:view_clients, false)
    {:ok, socket}
  end

  def handle_event("view_clients", _params, socket) do
    socket = socket
    |> assign(:view_clients, true)
    {:noreply, socket}
  end

  def handle_event("close", _params, socket) do
    socket = socket
    |> assign(:view_clients, false)
    {:noreply, socket}
  end
end
