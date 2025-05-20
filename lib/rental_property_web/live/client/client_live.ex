defmodule RentalPropertyWeb.ClientLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.CLIENTS 
  alias RentalProperty.TYPES 
  alias RentalProperty.PROVINCES 
  alias RentalProperty.DISTRICT 
  alias RentalProperty.NOTIFICATIONS
  alias RentalProperty.UPLOADS
  alias RentalProperty.TIERS
  alias RentalPropertyWeb.AddPropertyComponent
   

  def mount(_params, session, socket) do
   user = case CLIENTS.find_by_token(session["token"]) |> Map.from_struct() do
      
    result ->
      notifications = case NOTIFICATIONS.get_by_client_id(result.id) do
      [] -> []
      results -> for result <- results do Map.from_struct(result) end
      end
      notification_total = Enum.count(notifications)
      IO.inspect(notification_total, label: "TOTAL--->")

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
      |> assign(:fname, result.fname)
      |> assign(:lname, result.lname)
      |> assign(:gender, result.gender)
      |> assign(:phone, result.phone)
      |> assign(:tenant, result.tenant)
      |> assign(:notifications, notifications)
      |> assign(:notification_total, notification_total)
      |> assign(:properties, properties_map)
      |> assign(:properties_component, properties_map)
      |> assign(:property, "House")
      |> assign(:property_component, "House")
      |> assign(:provinces, provinces_map)
      |> assign(:search_area, false)
      |> assign(:districts, [])
      |> assign(:district_area, false)
      |> assign(:add_category, false)
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

  def handle_event("close_add_category", _params, socket) do
    socket = socket
    |> assign(:add_category, false)
    {:noreply, socket}
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
        name: tier_name.type,
        file_path: full_file_name,
        client_id: socket.assigns.client.id
      }
      
      UPLOADS.create_upload(uploads)
      {:ok, ~p"/uploads/#{Path.basename(dest)}"}
    end)
    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("add_property", _params, socket) do
    socket = socket
    |> assign(:add_category, true)
    {:noreply, socket}
  end


end
