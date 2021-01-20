defmodule Admin.MixProject do
  use Mix.Project

  def project do
    [
      app: :admin,
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
      extra_applications: [:logger, :plug_cowboy, :tesla],
      mod: {Admin.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.4"},
      {:ecto, "~> 3.5"},
      {:ecto_sql, "~> 3.5"},
      {:postgrex, "~> 0.15.7"},
      {:toml, "~> 0.6.2"},
      {:jason, "~> 1.2"},
      {:tesla, "~> 1.4.0"},
      {:hackney, "~> 1.16.0"},
      {:xml_builder, "~> 2.1"},
      {:elixir_xml_to_map, "~> 2.0"},
      {:credo, "~> 0.5", only: [:dev, :test]}
    ]
  end
end
