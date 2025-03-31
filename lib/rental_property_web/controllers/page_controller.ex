defmodule RentalPropertyWeb.PageController do
  use RentalPropertyWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def about(conn, _params) do
    conn
    |> render(:about) 
  end

  def handle_about(conn, params) do
    IO.inspect(params["name"], label: "PARAMS--->")
    render(conn, :about)
  end
end
