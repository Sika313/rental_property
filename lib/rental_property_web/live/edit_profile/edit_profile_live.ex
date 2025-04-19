defmodule RentalPropertyWeb.EditProfileLive do
  use RentalPropertyWeb, :live_view

  def mount(_params, session, socket) do
    IO.inspect(session, label: "EDIT PROFILE SESSION--->")
    {:ok, socket}
  end

end
