defmodule RentalPropertyWeb.Router do
  use RentalPropertyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RentalPropertyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RentalPropertyWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/about", PageController, :about
    post "/about", PageController, :handle_about
    
    live "/signup", SignupLive
    get "/login", PageController, :login 
    post "/login", PageController, :handle_login 
  end

  scope "/client", RentalPropertyWeb do
    live "/landing_page", ClientLive

  end

  # Other scopes may use custom stacks.
  # scope "/api", RentalPropertyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rental_property, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RentalPropertyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
