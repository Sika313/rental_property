defmodule RentalPropertyWeb.DashboardComponent do
  use RentalPropertyWeb, :live_component
  alias RentalProperty.USERS
  alias RentalProperty.CLIENTS
  alias RentalProperty.TYPES
  alias RentalProperty.PROPERTIES


 def update(assigns, socket) do
    total_users = USERS.list_users() |> Enum.count()
    total_clients = CLIENTS.list_clients() |> Enum.count()
    total_types = TYPES.list_types() |> Enum.count()
    total_properties = PROPERTIES.list_properties() |> Enum.count()
    t = PROPERTIES.list_properties() 
    total_properties_available = Enum.filter(t, fn property ->
      property.occupied == false
    end) |> Enum.count() 

    total_properties_unavailable = Enum.filter(t, fn property ->
      property.occupied == true 
    end) |> Enum.count() 


    socket = socket
    |> assign(:total_users, total_users)
    |> assign(:total_clients, total_clients)
    |> assign(:total_types, total_types)
    |> assign(:total_properties, total_properties)
    |> assign(:total_properties_available, total_properties_available)
    |> assign(:total_properties_unavailable, total_properties_unavailable)
    {:ok, socket}
  end


  def render(assigns) do
~H"""
    <div class="flex flex-row pt-4 pl-4 text-white text-center">

      <div class="flex flex-col mr-6 bg-orange-700 rounded-md items-center justify-around w-40 h-40">
        <h1>Total Users</h1>
        <b class="text-2xl"> <%= @total_users %> </b>
      </div>

      <div class="flex flex-col mr-6 bg-orange-700 rounded-md items-center justify-around w-40 h-40">
        <h1>Total Clients</h1>
        <b class="text-2xl"> <%= @total_clients %> </b>
      </div>

      <div class="flex flex-col mr-6 bg-orange-700 rounded-md items-center justify-around w-40 h-40">
        <h1>Total Types</h1>
        <b class="text-2xl"> <%= @total_types %> </b>
      </div>

      <div class="flex flex-col mr-4 bg-orange-700 rounded-md items-center justify-around w-40 h-40">
        <h1>Total Properties</h1>
        <b class="text-2xl"> <%= @total_properties %> </b>
      </div>

      <div class="flex flex-col mr-4 bg-orange-700 rounded-md items-center justify-around w-40 h-40">
        <h1>Total Properties available</h1>
        <b class="text-2xl"> <%= @total_properties_available %> </b>
      </div>

      <div class="flex flex-col mr-4 bg-orange-700 rounded-md items-center justify-around w-40 h-40">
        <h1>Total Properties unavailable</h1>
        <b class="text-2xl"> <%= @total_properties_unavailable %> </b>
      </div>



    </div>

"""
  end



end
