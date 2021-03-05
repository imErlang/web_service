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

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

config :logger,
  backends: [LoggerLagerBackend, :console],
  handle_otp_reports: false,
  level: :debug,
  truncate: :infinity

config :protobuffer,
  redis_key: %{
    host: "127.0.0.1",
    port: 6379,
    password: "123456",
    database: 1
  },
  navversion: "10000"

config :admin, port: 7004

config :admin, :ecto_repos, [Ejabberd.Repo]

import_config "#{config_env()}.exs"

config :admin,
  default_host: "startalk.tech",
  im_url: "http://127.0.0.1:10050",
  emo_dir: "upload/emoPackage/",
  base_dir: "upload/",
  download_url: "http://127.0.0.1:7004/qfproxy/",
  download_path: "file/v2/download/",
  single_portrait: "/file/v2/download/8c9d42532be9316e2202ffef8fcfeba5.png",
  muc_portrait: "/file/v2/download/eb574c5a1d33c72ba14fc1616cde3a42.png",
  rsa_public_key: "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCy2VXDAlCZlj7gPHvC/vwvbpTN\n/GyW0tmNCqh0UPitdTTGZk3UcLqu9lWMGPViL/5lhboiSogsDxJLHdwo91DDBjTX\n1HbuyuOhvsvayV7Yc8t+ajFW/8RwlvhGSzVplthoU+md9kGeZ8t73VWWZUEB0iyW\nx7Y/RjUwTdnOlNXDzQIDAQAB\n-----END PUBLIC KEY-----",
  rsa_private_key: "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCy2VXDAlCZlj7gPHvC/vwvbpTN/GyW0tmNCqh0UPitdTTGZk3U\ncLqu9lWMGPViL/5lhboiSogsDxJLHdwo91DDBjTX1HbuyuOhvsvayV7Yc8t+ajFW\n/8RwlvhGSzVplthoU+md9kGeZ8t73VWWZUEB0iyWx7Y/RjUwTdnOlNXDzQIDAQAB\nAoGAHlGlrkdoLoE/63eVa3saeVf/tePC7NaVtslFwWIwpgcmiTOyof7yRtLPsc5R\nWvHT6JYA9es4pm9vpHhNaEx0zjJkuAW9ECLb4dZA1b6stQy7nHl7dgT13RsEjKJI\n3CYLmK2Mneis9dObzz0CqMgdbAA456zQ4VuMlwJZzf0BT8ECQQDWipbxMey0tn+1\nI4lL+1JYfrfQZoA+dv0d8X2gt0d8itJFPQYWsJCt4vUl48c58E+hWarCBl+yl4ym\nz7RltmwpAkEA1WkIvwWlCyliUpgM7V0rp8vxBPyTXqNZ6+xiqVotX2PIQ116fNVW\n5Tx5DoAxQ/c+QALOZXAiY7BiAZ+AMl1PBQJAZaAYiAAiJCgerms66icOhqTf5XPo\nY65xj/GIlMy8rB4GJI4XiD/zCKttfJk9EhDnZ4LWBDqIskxfb9ULmvKioQJAfo6w\nWh/t1WWwYky7ddRH/FVMVGm4t2nl/KwNgmLw/128OH7qEbeutXkcTUYmcSjhaLKB\nVdSfAEFsjYvaSYPeRQJBANLk4jCONVQkYzSmnvqUrFvDOFq9Ei5J08waevFIoaia\nJJ9OvMg0AueWwHo/kfNz1GkCV6de4mKTshgT5d2V0T4=\n-----END RSA PRIVATE KEY-----",
  rsa_pub_key_shortkey:
    "MIIBCgKCAQEA2M6/CuCMgZmehFC/DA5cmYW1KS3U0qt+AnRco7Ijg0ohYyO1Mh/I88djJuvbHuja/wXZ3Fw9laQsykq1akVR0P3N8ax8FAX0Wb+oLszwIJDVzk748DspDvBUSmJ4w9fPUyyk8ENCntNqjp3qiOK2V2Jm7GitHtnwbe53c/ti3m/tjzYcixMCUoDjbRmYeu/I7jva8AHYPRzAg4Q7Bf4nKX3/2rYi23zWkSEdgPFPq31i8IsrEJPTai7usBU7ZU6nokF+LeeiY/d/cSOZe6FeTncf/8e4EXlgtbXuRqhV31hlXhGo/OLJRjkPyeklCHiWW8sEIsr+macFLU+K0u4StwIDAQAB",
  rsa_pub_key_fullkey:
    "-----BEGIN RSA PUBLIC KEY-----\nMIIBCgKCAQEA2M6/CuCMgZmehFC/DA5cmYW1KS3U0qt+AnRco7Ijg0ohYyO1Mh/I\n88djJuvbHuja/wXZ3Fw9laQsykq1akVR0P3N8ax8FAX0Wb+oLszwIJDVzk748Dsp\nDvBUSmJ4w9fPUyyk8ENCntNqjp3qiOK2V2Jm7GitHtnwbe53c/ti3m/tjzYcixMC\nUoDjbRmYeu/I7jva8AHYPRzAg4Q7Bf4nKX3/2rYi23zWkSEdgPFPq31i8IsrEJPT\nai7usBU7ZU6nokF+LeeiY/d/cSOZe6FeTncf/8e4EXlgtbXuRqhV31hlXhGo/OLJ\nRjkPyeklCHiWW8sEIsr+macFLU+K0u4StwIDAQAB\n-----END RSA PUBLIC KEY-----",
  pub_key_fullkey:
    "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCy2VXDAlCZlj7gPHvC/vwvbpTN\n/GyW0tmNCqh0UPitdTTGZk3UcLqu9lWMGPViL/5lhboiSogsDxJLHdwo91DDBjTX\n1HbuyuOhvsvayV7Yc8t+ajFW/8RwlvhGSzVplthoU+md9kGeZ8t73VWWZUEB0iyW\nx7Y/RjUwTdnOlNXDzQIDAQAB\n-----END PUBLIC KEY-----",
  pub_key_shortkey:
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCy2VXDAlCZlj7gPHvC/vwvbpTN/GyW0tmNCqh0UPitdTTGZk3UcLqu9lWMGPViL/5lhboiSogsDxJLHdwo91DDBjTX1HbuyuOhvsvayV7Yc8t+ajFW/8RwlvhGSzVplthoU+md9kGeZ8t73VWWZUEB0iyWx7Y/RjUwTdnOlNXDzQIDAQAB"

config :tesla, adapter: Tesla.Adapter.Hackney

config :ejabberd,
  file: "config/ejabberd.yml",
  log_path: 'log/ejabberd.log'

# Customize Mnesia directory:
config :mnesia,
  dir: 'mnesiadb/'
