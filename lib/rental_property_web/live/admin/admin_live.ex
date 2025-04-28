defmodule RentalPropertyWeb.AdminLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.ROLES
  alias RentalProperty.USERS

  def mount(_params, session, socket) do
    roles = ROLES.list_roles()
    |> then(fn roles -> for i <- roles do Map.from_struct(i) end end )
    socket = socket
    |> assign(:roles, roles)
    {:ok, socket}
  end

  def handle_event("create_user", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    token = UUID.uuid4()
    user = %{
      fname: params["fname"],
      lname: params["lname"],
      gender: params["gender"],
      phone: params["phone"],
      password: params["password"],
      token: token,
      role_id: String.to_integer(params["role"])
    }
    case USERS.create_user(user) do
      {:ok, _} ->
        socket = socket
        |> put_flash(:info, "User created successfully.")
        {:noreply, socket}
      {:error, _} ->
        socket = socket
        |> put_flash(:error, "User creation failed.")
        {:noreply, socket}
    end
  end

end
