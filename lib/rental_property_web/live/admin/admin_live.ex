defmodule RentalPropertyWeb.AdminLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.ROLES
  alias RentalProperty.USERS
  alias RentalProperty.CLIENTS
  alias RentalProperty.TIERS
  alias RentalProperty.TIER_UPGRADES
  alias RentalPropertyWeb.ViewUsersComponent 
  alias RentalPropertyWeb.ViewClientsComponent

  def mount(_params, session, socket) do
    pending_requests = TIER_UPGRADES.get_pending_requests() |> then(
      fn requests -> for request <- requests do Map.from_struct(request) end end
      
    )
    clients_pending_requests = for pending_request <- pending_requests do
      CLIENTS.get_client!(pending_request.client_id)
      |> Map.from_struct()
      |> Map.put(:upgrade_to, TIERS.get_tier!(pending_request.tier_id))
      |> Map.put(:request_id, pending_request.id)
    end

    total_pending_requests = Enum.count(pending_requests) |> IO.inspect(label: "Total pending requests--->")


    roles = ROLES.list_roles()
    |> then(fn roles -> for i <- roles do Map.from_struct(i) end end )

    tiers = TIERS.list_tiers() |> then(
      fn tiers -> for tier <- tiers do Map.from_struct(tier) end end
    )
    socket = socket
    |> assign(:roles, roles)
    |> assign(:tiers, tiers)
    |> assign(:view_users, false)
    |> assign(:total_pending_requests, total_pending_requests)
    |> assign(:clients_pending_requests, clients_pending_requests)
    |> assign(:client, %{id: "", fname: "", lname: "",gender: "", phone: "" })
    |> assign(:view_clients, false)
    {:ok, socket}
  end

  def handle_event("close_view_users", _params, socket) do
    socket = socket
    |> assign(:view_users, false)
    {:noreply, socket}
  end
  def handle_event("close_view_clients", _params, socket) do
    socket = socket
    |> assign(:view_clients, false)
    {:noreply, socket}
  end

  def handle_event("create_user", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    token = UUID.uuid4()
    user = %{
      fname: params["fname"],
      lname: params["lname"],
      gender: params["gender"],
      phone: params["phone"],
      password: params["password"],
      token: token,
      role_id: String.to_integer(params["role"])
    }
    case USERS.create_user(user) do
      {:ok, _} ->
        socket = socket
        |> put_flash(:info, "User created successfully.")
        {:noreply, socket}
      {:error, _} ->
        socket = socket
        |> put_flash(:error, "User creation failed.")
        {:noreply, socket}
    end
  end

  def handle_event("view_users", _params, socket) do
    socket = socket
    |> assign(:view_users, true)
    {:noreply, socket}
  end
  def handle_event("view_clients", _params, socket) do
    socket = socket
    |> assign(:view_clients, true)
    {:noreply, socket}
  end

  def handle_event("approve_upgrade", params, socket) do
    client = CLIENTS.get_client!(String.to_integer(params["client_id"]))
    CLIENTS.update_client( client, %{ tier_id: String.to_integer(params["tier_id"]) } )
    tier_upgrade_request = TIER_UPGRADES.get_tier_upgrade!(String.to_integer(params["request_id"])) |> IO.inspect(label: "TEST--->")
    TIER_UPGRADES.update_tier_upgrade(tier_upgrade_request, %{status: "approve"})
    socket = socket
    |> put_flash(:info, "Client tier updated successfully.")
    {:noreply, socket}
  end
  
  def handle_event("upgrade_tier", params, socket) do
    client = CLIENTS.get_client!(String.to_integer(params["client_id"])) |> Map.from_struct()
    socket = socket
    |> assign(:client, client)
    {:noreply, socket}
  end

  def handle_event("handle_upgrade_tier", params, socket) do
    IO.inspect(params, label: "P--->")
    tier_upgrade_request = %{
      client_id: String.to_integer(params["client_id"]),
      tier_id: String.to_integer(params["tier_id"]),
      status: "pending"
    }
    TIER_UPGRADES.create_tier_upgrade(tier_upgrade_request)
    socket = socket
    |> put_flash(:info, "Upgrade request sent to admin for approval.")
    {:noreply, socket}
  end

end
