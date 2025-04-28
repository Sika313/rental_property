defmodule RentalPropertyWeb.PageController do
  use RentalPropertyWeb, :controller
  import Phoenix.LiveView.Controller

  alias RentalProperty.CLIENTS
  alias RentalProperty.USERS

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home)
  end

  def about(conn, _params) do
    conn
    |> render(:about) 
  end

  def handle_about(conn, params) do
    render(conn, :about)
  end

  def login(conn, _params) do
    render(conn, :login)
  end

  def handle_login(conn, params) do
    case USERS.find_by_phone_and_password(params) do
    {:error} ->
    case CLIENTS.find_by_phone_and_password(params) do
      {:ok, result} ->
        r = Map.from_struct(result)
        conn 
        |> put_flash(:info, "Logged in successfully.")
        |> put_session(:token, r.token)
        |> live_render(RentalPropertyWeb.ClientLive)
      {:error} ->
        conn 
        |> put_flash(:error, "Credentials incorrect.")
        |> redirect(to: "/login")
    end
    {:ok, result} ->
      r = Map.from_struct(result)
      to_render = cond do
        r.role_id == 1 -> RentalPropertyWeb.AdminLive 
        r.role_id == 2 -> RentalPropertyWeb.AccountantLive 
      end
      conn
      |> put_flash(:info, "Logged in successfully.")
      |> put_session(:token, r.token)
      |> live_render(to_render) 

    end
  end

  def logout(conn, _params) do
    conn = conn
    |> clear_session()
    |> put_flash(:info, "Successfully logged out.")
    |> redirect(to: "/")
    conn
  end

end
