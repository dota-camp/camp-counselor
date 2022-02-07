import Config

config :nostrum,
  token: System.get_env("DISCORD_TOKEN"),
  num_shards: :auto

config :counselor,
  env: Mix.env(),
  ecto_repos: [Counselor.Repo]

config :logger, :console,
  format: "\n$time [$level] $levelpad $message $metadata\n",
  metadata: [:interaction_data, :guild_id, :channel_id, :user_id]

import_config "#{Mix.env()}.exs"
