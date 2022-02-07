import Config

config :logger,
  level: :debug

config :counselor, Counselor.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "counselor",
  username: "postgres",
  hostname: "localhost"

import_config "dev.secret.exs"
