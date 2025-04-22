defmodule RentalPropertyWeb.ClientLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.CLIENTS 
  alias RentalProperty.TYPES 
  alias RentalProperty.PROVINCES 
  alias RentalProperty.DISTRICT 
  

  def mount(_params, session, socket) do
   user = case CLIENTS.find_by_token(session["token"]) |> Map.from_struct() do
   
    result ->
      properties = TYPES.list_types() 
      properties_map = for property <- properties do
        Map.from_struct(property)
      end
      provinces = PROVINCES.list_provinces()
      provinces_map = for province <- provinces do
        Map.from_struct(province)
      end
      socket = socket
      |> assign(:fname, result.fname)
      |> assign(:lname, result.lname)
      |> assign(:gender, result.gender)
      |> assign(:phone, result.phone)
      |> assign(:tenant, result.tenant)
      |> assign(:properties, properties_map)
      |> assign(:property, "House")
      |> assign(:provinces, provinces_map)
      |> assign(:search_area, false)
      |> assign(:districts, [])
      |> assign(:district_area, false)
     {:ok, socket} 
    {:error} ->
      []
   end
    if user == [] do
      socket = socket
      |> put_flash(:error, "Something went wrong, try again.")
      |> redirect(to: "/login")
    else
      {:ok, socket}
    end
    user
  end

  def handle_event("category", params, socket) do
    socket = socket
    |> assign(:property, params["property"])
    |> assign(:search_area, true)
    {:noreply, socket}
  end

  def handle_event("province", params, socket) do
    id = params["province_id"] |> String.to_integer()
    case DISTRICT.get_by_province_id(id) do
      {:no_results_found} ->
        socket = socket
        |> put_flash(:error, "No Districts found")
        {:noreply, socket}
      results ->
        results_map = for result <- results do
          Map.from_struct(result)
        end
        socket = socket
        |> assign(:districts, results_map)
        |> assign(:district_area, true)
        {:noreply, socket}
    end
  end

  def handle_event("district", params, socket) do
    {:noreply, socket}
  end

end
