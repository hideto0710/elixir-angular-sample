# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :friday_front,
  ecto_repos: [FridayFront.Repo]

# Configures the endpoint
config :friday_front, FridayFront.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OrxxLQH7ghlgufdnjG6l/tCXH+RJNvRfa9hd8B60L1rxMd8sa//xV2sG5OABpKuY",
  render_errors: [view: FridayFront.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FridayFront.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :friday_front, :github,
  base_url: "https://api.github.com",
  repository: "hideto0710/elixir-angular-sample"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
