# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lifehope_attendance,
  ecto_repos: [LifehopeAttendance.Repo],
  admin_auth:
    [
      username: "admin",
      password: "admin",
      realm: "Admin Area"
    ]

# Configures the endpoint
config :lifehope_attendance, LifehopeAttendance.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oJ6OgmfUZUXXhhf6TFqDAugVlO/62K7JvSIstnlizMOo1fjwQNbl/UVluKT01Omf",
  render_errors: [view: LifehopeAttendance.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LifehopeAttendance.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
