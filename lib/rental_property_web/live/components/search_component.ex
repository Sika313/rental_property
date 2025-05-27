defmodule RentalPropertyWeb.SearchComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.PROPERTIES
  alias RentalProperty.CLIENTS

  def update(assigns, socket) do
    results = PROPERTIES.get_by_map(assigns.search_map) 
    result_map = cond do
      results != [] -> for r <- results do Map.from_struct(r) end
      results == [] -> []
    end
    results = for r <- result_map do
      client = CLIENTS.get_client!(r.client_id) |> Map.from_struct()
      Map.put(r, :client, client)
    end
    socket = socket
    |> assign(:result_map, results)
    {:ok, socket}    
  end

  def render(assigns) do
    ~H"""
      <div class="border-t-2 border-orange-500">
        <button phx-click="close_search">Close</button>
        <%= if @result_map == [] do %>
          <h1>No item found</h1>
        <% else %>
         <div class="flex flex-row justify-around">  
          <%= for property <- @result_map do %>
            <!-- START -->
            <%= if property.occupied == false do %>
            <div class="flex flex-col">
              <img src={"/images/uploads/" <> property.image_one} alt="Img" class="w-60 h-60" />
              <p>Description: <%= property.description %></p>
              <p >Price: <%= property.price %></p>
              <%= if property.occupied == false do %>
                <p>Status: Available</p>
              <% else %>
                <p>Status: Not available</p>
              <% end %>
              <h1 class="mt-4"><b>Owner details</b></h1>
              <ul>
                <li>Name: <%= property.client.fname %> <%= property.client.lname %> </li>
                <li>Phone number: <%= property.client.phone %> </li>
              </ul>
            </div>
            <% else %>
              <h1>No item found.</h1>
            <% end %>
            <!-- END -->
          <% end %>
         </div>
        <% end %>
      </div>
    """
  end

end
