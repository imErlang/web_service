# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :admin, Ejabberd.Repo,
  database: "admin_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]

config :admin, port: 7003

config :admin, :ecto_repos, [Ejabberd.Repo]

config :admin, Ejabberd.Repo,
  database: "ejabberd",
  username: "postgres",
  password: "123456",
  hostname: "localhost",
  port: 5432,
  priv: "priv/user"
