defmodule RentalPropertyWeb.ClientLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.CLIENTS 
  alias RentalProperty.TYPES 
  alias RentalProperty.PROVINCES 
  alias RentalProperty.DISTRICT 
  alias RentalProperty.NOTIFICATIONS
  alias RentalProperty.UPLOADS
  alias RentalProperty.TIERS
  alias RentalProperty.PROPERTIES
  alias RentalPropertyWeb.AddPropertyComponent
  alias RentalPropertyWeb.SearchComponent
   

  def mount(_params, session, socket) do
   user = case CLIENTS.find_by_token(session["token"]) |> Map.from_struct() do
      
    result ->
      notifications = case NOTIFICATIONS.get_by_client_id(result.id) do
      [] -> []
      results -> for result <- results do Map.from_struct(result) end
      end
      notification_total = Enum.count(notifications)
      client_properties = PROPERTIES.find_by_client_id(result.id) 
      client_properties = for client_property <- client_properties do
        Map.from_struct(client_property)
      end

      properties = TYPES.list_types() 
      properties_map = for property <- properties do
        Map.from_struct(property)
      end
      provinces = PROVINCES.list_provinces()
      provinces_map = for province <- provinces do
        Map.from_struct(province)
      end
      socket = socket
      |> assign(:tier_id, result.tier_id)
      |> assign(:client_properties, client_properties)
      |> assign(:user, result)
      |> assign(:fname, result.fname)
      |> assign(:client_id, result.id)
      |> assign(:lname, result.lname)
      |> assign(:gender, result.gender)
      |> assign(:phone, result.phone)
      |> assign(:tenant, result.tenant)
      |> assign(:notifications, notifications)
      |> assign(:notification_total, notification_total)
      |> assign(:properties, properties_map)
      |> assign(:properties_component, properties_map)
      |> assign(:property, "House")
      |> assign(:provinces, provinces_map)
      |> assign(:search, false)
      |> assign(:search_area, true)
      |> assign(:districts, [])
      |> assign(:district_area, false)
      |> assign(:add_category, false)
      |> assign(:add_property, false)
      |> assign(:search_map, %{type_id: 1, province_id: 1, district_id: 1})
      |> assign(:uploaded_files, [])
      |> allow_upload(:avatar, accept: ~w(.jpg), max_entries: 2)

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

  def handle_event("close_add_property", _params, socket) do
    socket = socket
    |> assign(:add_property, false)
    |> assign(:search_area, true)
    {:noreply, socket}
  end

  def handle_event("close_search", _params, socket) do
    socket = socket
    |> assign(:search, false)
    {:noreply, socket}
  end


  def handle_event("category", params, socket) do
    socket = socket
    |> assign(:property, params["property"])
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



  def handle_event("save", params, socket) do
  IO.inspect(params, label: "PARAMS--->")
  uploaded_files =
    consume_uploaded_entries(socket, :avatar, fn %{path: path}, _entry ->
      dest = Path.join(Application.app_dir(:rental_property, "priv/static/images/uploads"), Path.basename(path))
      # You will need to create `priv/static/uploads` for `File.cp!/2` to work.
      File.cp!(path, dest <> ".jpg")
      file_name = String.splitter(dest, "/") |> Enum.take(-1)
      full_file_name = Enum.at(file_name, 0) <> ".jpg"

      tier_name = TIERS.get_tier!(socket.assigns.tier_id)
      tier_name = Map.from_struct(tier_name)

      uploads = %{
        number_of_rooms: params["number_of_rooms"],
        location: params["location"],
        description: params["description"],
        price: params["price"],
        occupied: false,
        image_one: full_file_name,
        image_two: "two",
        image_three: "three",
        image_four: "four",
        client_id: socket.assigns.client_id,
        type_id: socket.assigns.tier_id,
        province_id: String.to_integer(params["province"]),
        district_id: String.to_integer(params["district"])
      }
      p = String.to_integer(params["province"]) 
      IO.inspect(p)
      IO.inspect(uploads)
      
      PROPERTIES.create_property(uploads)
      {:ok, ~p"/uploads/#{Path.basename(dest)}"}
    end)
    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("add_property", _params, socket) do
    socket = socket
    |> assign(:search_area, false)
    |> assign(:add_property, true)
    {:noreply, socket}
  end

  def handle_event("handle_add_property", params, socket) do
    IO.inspect(params, label: "UPLOAD--->")
    {:noreply, socket}
  end

  def handle_event("search", _params, socket) do
    socket = socket
    |> assign(:search, true)
    {:noreply, socket}
  end

  def handle_event("handle_search", params, socket) do
    IO.inspect(params, label: "HANDLE SEARCH--->")
    type = TYPES.get_type_by_name(params["property"]) |> Enum.at(0) |> Map.from_struct()
    IO.inspect(type, label: "TYPE--->")

    province = PROVINCES.get_province_by_name(params["province"]) |> Enum.at(0) |> Map.from_struct()
    district = DISTRICT.get_district_by_name(params["district"]) |> Enum.at(0) |> Map.from_struct()

    search = %{type_id: type.client_type, province_id: province.id, district_id: district.id}
    IO.inspect(search, label: "SEARCH--->")
    socket = socket
    |> assign(:search_map, search)
    |> assign(:search, true)
    {:noreply, socket}
  end

  def handle_event("change_status", params, socket) do
      client_properties = PROPERTIES.find_by_client_id(socket.assigns.user.id) 
      client_property = Enum.at(client_properties, 0)
      IO.inspect(client_property, label: "AAAA___--->")
    PROPERTIES.update_property(client_property, %{occupied: params["change_status"]})

      client_properties = PROPERTIES.find_by_client_id(socket.assigns.user.id) 
      client_properties_map = for client_property <- client_properties do
        Map.from_struct(client_property)
      end

    socket = socket
    |> assign(:client_properties, client_properties)
    |> put_flash(:info, "Property successfully updated.")
    {:noreply, socket}
  end

end
