import Config

config :admin, Ejabberd.Repo,
  database: "ejabberd",
  username: "postgres",
  password: "123456",
  hostname: "127.0.0.1",
  port: 5432,
  priv: "priv/user"

config :admin,
  server_ip: "127.0.0.1",
  server_port: 7004
