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
      {:cowboy, "~> 2.7", override: true},
      {:lager, "~> 3.8.1", override: true},
      {:jiffy, "~> 1.0.8", override: true},
      {:stun, "~> 1.0.41", override: true},
      {:p1_utils, "~> 1.0.21", override: true},
      {:jose, "~> 1.11.1", override: true},
      {:idna, "~> 6.1", override: true}
    ]
  end
end
