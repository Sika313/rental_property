defmodule RentalPropertyWeb.AddPropertyComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.TYPES

 def update(assigns, socket) do
    IO.inspect(assigns.tier_id)
    socket = socket
    |> assign(:properties, assigns.properties)
    |> assign(:property, assigns.property)
    |> assign(:provinces, assigns.provinces)
    |> assign(:districts, assigns.districts)
    |> assign(:uploaded_files, [])
    |> allow_upload(:avatar, accept: ~w(.jpg), max_entries: 2)
    {:ok, socket}
  end


  def render(assigns) do
~H"""
    <div>
    <button phx-click="close_add_property">Close</button>

<!-- CATEGORIES -->
<form id="upload-form" phx-submit="save" phx-change="validate" class="flex flex-col">
<input type="text" id="category" name="category" class="hidden" />
  <!-- PROVINCE -->
<span>
<label for="province">Province</label>
<select id="province" name="province" class="mr-10">
 <%= for province <- @provinces do %>
  <option phx-value-province_id={province.id} phx-click="province"> <%= province.name %> </option>
 <% end %>
</select>
</span>

  <!-- DISTRICT -->
<span>
<label for="district">District</label>
<select id="district" name="district">
 <%= for district <- @districts do %>
  <option phx-value-district_id={district.id} phx-click="district" selected> <%= district.name %> </option>
 <% end %>
</select>
</span>

<label for="number_of_rooms">Number of rooms</label>
<input id="number_of_rooms" name="number_of_rooms" />

<label for="location">Location</label>
<input id="location" name="location" />

<label for="description">Description</label>
<input id="description" name="description" />

<label for="price">Price</label>
<input id="price" name="price" />


 <.live_file_input upload={@uploads.avatar} /> <br />

<button type="submit" phx-click="close_add_property">Upload</button>
</form>

    </div>

"""
  end



end
