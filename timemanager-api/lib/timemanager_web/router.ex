defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router

  import TimemanagerWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["json"]
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    # plug :fetch_session
    # plug :fetch_current_user
    # plug :protect_from_forgery, with: :null_session
  end

  pipeline :authenticated do
    plug TimemanagerWeb.Plug.Authenticate
    plug TimemanagerWeb.Plug.CSRFProtection
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :timemanager, swagger_file: "swagger.json"
  end

  scope "/api", TimemanagerWeb do
    pipe_through :api
    post "/login", SessionController, :login
  end

  scope "/api", TimemanagerWeb do
    pipe_through [:api, :authenticated]

    delete "/logout", SessionController, :logout

    #Users routes

    get "/users", UserController, :index
    get "/managers", UserController, :managers
    get "/users/:id", UserController, :show
    get "/supervisors", UserController, :supervisors
    post "/users", UserController, :create
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
    post "/users/register", UserController, :create

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
end
