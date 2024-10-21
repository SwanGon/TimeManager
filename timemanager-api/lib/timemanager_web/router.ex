defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router

  import TimemanagerWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TimemanagerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_current_user
    plug :protect_from_forgery, with: :null_session
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :timemanager, swagger_file: "swagger.json"
  end

  # Other scopes may use custom stacks.
  scope "/api", TimemanagerWeb do
    pipe_through :api
    #Users routes

    get "/users", UserController, :index
    get "/managers", UserController, :managers
    get "/users/:id", UserController, :show
    post "/users", UserController, :create
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete

    #Working times routes
    get "/workingtimes/:user_id", WorkingTimeController, :index
    get "/workingtimes/:user_id/:id", WorkingTimeController, :show
    post "/workingtimes/:user_id", WorkingTimeController, :create
    put "/workingtimes/:id", WorkingTimeController, :update
    delete "/workingtimes/:id", WorkingTimeController, :delete

    #Clocks routes
    get "/clocks/:user_id", ClockController, :index
    post "/clocks/:user_id", ClockController, :create

    #Teams routes
    get "/teams", TeamController, :index
    get "/teams/:id", TeamController, :show
    get "/teamsmanager/:manager_id", TeamController, :manager
    post "/teams", TeamController, :create
    put "/teams/:id", TeamController, :update
    delete "/teams/:id", TeamController, :delete

  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Time Manager",
      }
    }
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  #if Application.compile_env(:timemanager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    #import Phoenix.LiveDashboard.Router

    #scope "/dev" do
    #  pipe_through :browser

    #  live_dashboard "/dashboard", metrics: TimemanagerWeb.Telemetry
    #  forward "/mailbox", Plug.Swoosh.MailboxPreview
    #end
  #end

  ## Authentication routes

  scope "/", TimemanagerWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{TimemanagerWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end
  get "/api/csrf_token", SessionController, :csrf_token

  scope "/", TimemanagerWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{TimemanagerWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", TimemanagerWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{TimemanagerWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
