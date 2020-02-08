# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :mcf_phoenix, McfPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gxfjgDU8TgtR2ys6AZHzPOCCMwfc8Sxv+U7tttW+9pBoqaZjeqbRq3Bg8N6oYxAR",
  render_errors: [view: McfPhoenixWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: McfPhoenix.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "Rq4Elk9kXgSMn8qgA7ZIDoNg5yTB+D0s"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
