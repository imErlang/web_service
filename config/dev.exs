import Config

config :admin, Ejabberd.Repo,
  database: "ejabberd",
  username: "postgres",
  password: "123456",
  hostname: "192.168.18.128",
  port: 5432,
  priv: "priv/user"
