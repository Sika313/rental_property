defmodule RentalPropertyWeb.SearchComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.PROPERTIES

  def update(assigns, socket) do
    results = PROPERTIES.get_by_map(assigns.search_map) 
    result_map = cond do
      results != [] -> for r <- results do Map.from_struct(r) end
      results == [] -> []
    end
    IO.inspect(result_map)
    socket = socket
    |> assign(:result_map, result_map)
    {:ok, socket}    
  end

  def render(assigns) do
    ~H"""
      <div>
        <button phx-click="close_search">Close</button>
        <%= if @result_map == [] do %>
          <h1>No item found</h1>
        <% else %>
        <h1>---LOADING---</h1>
         <div class="flex flex-row justify-around">  
          <%= for property <- @result_map do %>
            <div class="flex flex-col">
              <img src={"/images/uploads/" <> property.image_one} alt="Img" class="w-60 h-60" />
              <p><%= property.price %></p>
            </div>
          <% end %>
         </div>
        <% end %>
      </div>
    """
  end

end
