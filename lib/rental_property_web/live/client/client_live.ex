defmodule RentalPropertyWeb.ClientLive do
  use RentalPropertyWeb, :live_view
  alias RentalProperty.CLIENTS 

  def mount(_params, session, socket) do
   user = case CLIENTS.find_by_token(session["token"]) |> Map.from_struct() do
    result ->
      socket = socket
      |> assign(:fname, result.fname)
      |> assign(:lname, result.lname)
      |> assign(:gender, result.gender)
      IO.inspect(socket, label: "CLIENT SOCKET--->")
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

end
