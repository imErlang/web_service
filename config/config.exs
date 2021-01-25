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
config :logger, :console,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:user_id]

config :admin, port: 7004

config :admin, :ecto_repos, [Ejabberd.Repo]

import_config "#{config_env()}.exs"

config :admin,
  default_host: "startalk.tech",
  im_url: "http://127.0.0.1:10050",
  emo_dir: "upload/emoPackage/",
  base_dir: "upload/",
  download_url: "https://im.startalk.tech:8443/",
  download_path: "file/v2/download/",
  rsa_pub_key_shortkey:
    "MIIBCgKCAQEA2M6/CuCMgZmehFC/DA5cmYW1KS3U0qt+AnRco7Ijg0ohYyO1Mh/I88djJuvbHuja/wXZ3Fw9laQsykq1akVR0P3N8ax8FAX0Wb+oLszwIJDVzk748DspDvBUSmJ4w9fPUyyk8ENCntNqjp3qiOK2V2Jm7GitHtnwbe53c/ti3m/tjzYcixMCUoDjbRmYeu/I7jva8AHYPRzAg4Q7Bf4nKX3/2rYi23zWkSEdgPFPq31i8IsrEJPTai7usBU7ZU6nokF+LeeiY/d/cSOZe6FeTncf/8e4EXlgtbXuRqhV31hlXhGo/OLJRjkPyeklCHiWW8sEIsr+macFLU+K0u4StwIDAQAB",
  rsa_pub_key_fullkey:
    "-----BEGIN RSA PUBLIC KEY-----\nMIIBCgKCAQEA2M6/CuCMgZmehFC/DA5cmYW1KS3U0qt+AnRco7Ijg0ohYyO1Mh/I\n88djJuvbHuja/wXZ3Fw9laQsykq1akVR0P3N8ax8FAX0Wb+oLszwIJDVzk748Dsp\nDvBUSmJ4w9fPUyyk8ENCntNqjp3qiOK2V2Jm7GitHtnwbe53c/ti3m/tjzYcixMC\nUoDjbRmYeu/I7jva8AHYPRzAg4Q7Bf4nKX3/2rYi23zWkSEdgPFPq31i8IsrEJPT\nai7usBU7ZU6nokF+LeeiY/d/cSOZe6FeTncf/8e4EXlgtbXuRqhV31hlXhGo/OLJ\nRjkPyeklCHiWW8sEIsr+macFLU+K0u4StwIDAQAB\n-----END RSA PUBLIC KEY-----",
  pub_key_fullkey:
    "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCy2VXDAlCZlj7gPHvC/vwvbpTN\n/GyW0tmNCqh0UPitdTTGZk3UcLqu9lWMGPViL/5lhboiSogsDxJLHdwo91DDBjTX\n1HbuyuOhvsvayV7Yc8t+ajFW/8RwlvhGSzVplthoU+md9kGeZ8t73VWWZUEB0iyW\nx7Y/RjUwTdnOlNXDzQIDAQAB\n-----END PUBLIC KEY-----",
  pub_key_shortkey:
    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCy2VXDAlCZlj7gPHvC/vwvbpTN/GyW0tmNCqh0UPitdTTGZk3UcLqu9lWMGPViL/5lhboiSogsDxJLHdwo91DDBjTX1HbuyuOhvsvayV7Yc8t+ajFW/8RwlvhGSzVplthoU+md9kGeZ8t73VWWZUEB0iyWx7Y/RjUwTdnOlNXDzQIDAQAB"

config :tesla, adapter: Tesla.Adapter.Hackney
