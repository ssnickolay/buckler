defmodule DB.Mixfile do
  use Mix.Project

  def project do
    [
      app: :db,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      # build_embedded: Mix.env == :prod,
      # start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      # extra_applications: [
      #   :logger
      # ],
      # mod: {DB.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 2.1"}
    ]
  end
end
