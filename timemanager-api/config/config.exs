# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :timemanager,
  ecto_repos: [Timemanager.Repo],
  generators: [timestamp_type: :utc_datetime]


# Configures the endpoint
config :timemanager, TimemanagerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: TimemanagerWeb.ErrorHTML, json: TimemanagerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Timemanager.PubSub,
  live_view: [signing_salt: "wSa8g/rj"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :timemanager, Timemanager.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  timemanager: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

  # config :timemanager, TimemanagerApi.Endpoint,
  # http: [port: 4000],
  # url: [host: "localhost", port: 4000],
  # cors: [
  #   origins: ["http://localhost:5173"],
  #   allow_headers: ["Content-Type", "Accept", "Authorization"],
  #   allow_methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
  # ]
# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  timemanager: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
# Configuration de corps_plug
config :cors_plug,
  origin: ["*"],
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "DELETE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :timemanager, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: TimemanagerWeb.Router,     # phoenix routes will be converted to swagger paths
      endpoint: TimemanagerWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
    ]
  }

config :phoenix_swagger, json_library: Jason
config :joken,
  rsa_key: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN PUBLIC KEY-----
    ...vDXvkj5DmWITJ9itQx161xs1R3DdwsiHMIrvwQ/lR3ReYeCxE3BxLGmIz1Zguozn...
    -----END PUBLIC KEY-----
    """
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
