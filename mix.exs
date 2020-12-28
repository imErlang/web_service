defmodule WebService.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:distillery, "~> 2.1"},
      {:toml, "~> 0.6.2"},
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:ecto_sql, "~> 3.5"},
      {:jason, "~> 1.2"},
      {:postgrex, "~> 0.15.7"}
    ]
  end
end
