defmodule RentalPropertyWeb.ViewClientsComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.CLIENTS
  alias RentalProperty.TIERS

  def update(assigns, socket) do
    clients = for client <- CLIENTS.list_clients do
      Map.from_struct(client)
    end
    clients_with_tier = for client <- clients do
      tier = TIERS.get_tier!(client.tier_id) |> Map.from_struct()
      Map.put(client, :tier_name, tier.type)
    end
    tiers = for client <- clients do
      TIERS.get_tier!(client.tier_id) |> Map.from_struct()
    end
    IO.inspect(assigns.client, label: "PARENT CLIENT--->")
    socket = socket
    |> assign(:clients, clients_with_tier)
    |> assign(:client, assigns.client)
    |> assign(:tiers, assigns.tiers)
    {:ok, socket}
  end


  def render(assigns) do
   ~H"""

<div class="relative overflow-x-auto">
    <button phx-click="close_view_clients">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                  First name
                </th>
                <th scope="col" class="px-6 py-3">
                  Last name 
                </th>
                <th scope="col" class="px-6 py-3">
                  Gender 
                </th>
                <th scope="col" class="px-6 py-3">
                  Phone number 
                </th>
                <th scope="col" class="px-6 py-3">
                  Tier 
                </th>
                 <th scope="col" class="px-6 py-3">
                </th>
                                 
            </tr>
        </thead>
        <tbody>
          <%= for client <- @clients do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= client.fname %> 
                </th>
                <td class="px-6 py-4">
                  <%= client.lname %> 
                </td>
                <td class="px-6 py-4">
                  <%= client.gender %> 
                </td>
                <td class="px-6 py-4">
                  <%= client.phone %>  
                </td>
                <td class="px-6 py-4">
                  <%= client.tier_name %>  
                </td>
                <td class="px-6 py-4">
                <form phx-submit="upgrade_tier">
                  <input type="text" name="client_id" value={client.id} class="hidden" />
                  <button type="submit" phx-click={show_modal("upgrade_tier")} class="bg-blue-500 text-white px-4 py-2">Request Tier Uprgade</button>
                  </form>
                </td>

            </tr>
          <% end %>
      </tbody>
    </table>
    <.modal id="upgrade_tier">
        <form phx-submit="handle_upgrade_tier" class="flex flex-col">
        <p> <%= @client.fname %> <%= @client.lname %> </p>
        <p> <%= @client.gender %> </p>
        <p> <%= @client.phone %> </p>
          <input type="text" name="client_id" value={@client.id} class="hidden" />
          <label for="tiers">Choose tier</label>
          <select id="tiers" name="tier_id">
            <%= for tier <- @tiers do %>
              <option value={tier.id}><%= tier.type %></option>
            <% end %>
          </select>
        <button type="submit" phx-click="close_view_clients" class="bg-blue-600 text-white px-4 py-2">
          Request Upgrade
        </button>
        </form>
    </.modal>
</div>

   """
  end



end
