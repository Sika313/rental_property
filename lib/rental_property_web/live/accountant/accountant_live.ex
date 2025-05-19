defmodule RentalPropertyWeb.AccountantLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.ROLES
  alias RentalProperty.USERS
  alias RentalProperty.CLIENTS
  alias RentalProperty.TIERS
  alias RentalPropertyWeb.ViewClientsComponent

  def mount(_params, session, socket) do
    roles = ROLES.list_roles()
    |> then(fn roles -> for i <- roles do Map.from_struct(i) end end )
    tiers = TIERS.list_tiers() |> then(
      fn tiers -> for tier <- tiers do Map.from_struct(tier) end end
    )
    socket = socket
    |> assign(:roles, roles)
    |> assign(:tiers, tiers)
    |> assign(:view_clients, false)
    |> assign(:client, %{fname: "", lname: "",gender: "", phone: "" })
    {:ok, socket}
  end

  def handle_event("view_clients", _params, socket) do
    socket = socket
    |> assign(:view_clients, true)
    {:noreply, socket}
  end

  def handle_event("close_view_clients", _params, socket) do
    socket = socket
    |> assign(:view_clients, false)
    {:noreply, socket}
  end
  
  def handle_event("upgrade_tier", params, socket) do
    IO.inspect(params, label: "UT--->")
    client = CLIENTS.get_client!(String.to_integer(params["client_id"])) |> Map.from_struct()
    socket = socket
    |> assign(:client, client)
    {:noreply, socket}
  end

  def handle_event("handle_upgrade_tier", params, socket) do
    socket = socket
    |> put_flash(:info, "Upgrade request sent to admin for approval.")
    {:noreply, socket}
  end

end
