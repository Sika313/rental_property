defmodule RentalPropertyWeb.ClientController do
  use RentalPropertyWeb, :controller
  import Phoenix.LiveView.Controller

  def upgrade_tier(conn, _params) do
    token = get_session(conn, :token)
    conn
    |> put_session(:token, token)
    |> live_render(RentalPropertyWeb.UpgradeTierLive)
    conn
  end

end
