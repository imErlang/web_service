defmodule Protobuffer.MixProject do
  use Mix.Project

  def project do
    [
      app: :protobuffer,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Protobuffer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:protobuf, "~> 0.7.1"},
      {:fast_xml, "~> 1.1"},
      {:ejabberd, "~> 21.1"},
      {:xmpp, "~> 1.5.2"},
      {:redix, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:jiffy, "~> 1.0.8"}
    ]
  end
end
