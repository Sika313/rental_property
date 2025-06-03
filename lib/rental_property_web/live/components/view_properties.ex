defmodule RentalPropertyWeb.ViewPropetiesComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.PROPERTIES
  alias RentalProperty.TIERS
  alias RentalProperty.PROVINCES
  alias RentalProperty.DISTRICT
  alias RentalProperty.CLIENTS
  alias RentalProperty.TYPES

  def update(assigns, socket) do
    properties = PROPERTIES.list_properties() 
    
    properties_one = for property <- properties do
      type = TYPES.get_type!(property.type_id - 1) |> Map.from_struct()
            client = CLIENTS.get_client!(property.client_id) |> Map.from_struct()
      Map.put(property, :type, type)
    end
    properties_two = for property <- properties_one do
      province = PROVINCES.get_province!(property.province_id) |> Map.from_struct()
      Map.put(property, :province, province)
    end

    properties_three = for property <- properties_two do
      district = DISTRICT.get_district!(property.district_id) |> Map.from_struct()
      Map.put(property, :district, district)
    end

    properties_four = for property <- properties_three do
      client = CLIENTS.get_client!(property.client_id) |> Map.from_struct()
      Map.put(property, :client, client)
    end

    IO.inspect(properties_four, label: "PROPERTIES--->")
    socket = socket
    |> assign(:properties, properties_four)
    {:ok, socket}
  end


  def render(assigns) do
   ~H"""

<div class="relative overflow-x-auto">
    <button phx-click="close_view_properties">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                 Property type  
                </th>
                <th scope="col" class="px-6 py-3">
                  Province 
                </th>
                <th scope="col" class="px-6 py-3">
                  District 
                </th>
                <th scope="col" class="px-6 py-3">
                  Price 
                </th>
                <th scope="col" class="px-6 py-3">
                  Status 
                </th>
                 <th scope="col" class="px-6 py-3">
                </th>
                                 
            </tr>
        </thead>
        <tbody>
          <%= for property <- @properties do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= property.type.property_type %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= property.province.name %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= property.district.name %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= property.price %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                  <%= if property.occupied do %>
                    Not available 
                  <% else %>
                    Available
                  <% end %>
                </th>

             </tr>
          <% end %>
      </tbody>
    </table>
    </div>

   """
  end



end
