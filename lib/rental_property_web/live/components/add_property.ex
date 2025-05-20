defmodule RentalPropertyWeb.AddPropertyComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.TYPES

  def update(assigns, socket) do
    IO.inspect(assigns.properties, label: "ASS--->")
    socket = socket
    |> assign(:properties, assigns.properties)
    |> assign(:property, assigns.property)
    {:ok, socket}
  end


  def render(assigns) do
   ~H"""
    <div>
    <button phx-click="close_add_category">Close</button>
<span>
<label for="category">Category</label>
<select id="property" name="property" class="mr-10">
 <%= for property <- @properties do %>
  <%= if property.property_type == @property do %>
  <option phx-value-property={property.property_type} phx-click="category" selected> <%= property.property_type %> </option>
  <% else %>
  <option phx-value-property={property.property_type} phx-click="category"> <%= property.property_type %> </option>
  <% end %>
 <% end %>
</select>
</span>


    </div>

   """
  end



end
