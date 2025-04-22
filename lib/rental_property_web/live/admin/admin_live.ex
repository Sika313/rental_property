defmodule RentalPropertyWeb.AdminLive do
  use RentalPropertyWeb, :live_view

  def mount(_params, session, socket) do
    IO.inspect(session, label: "SESSION--->")
    {:ok, socket}
  end

end
