defmodule PaypalExporter.MixProject do
  use Mix.Project

  def project do
    [
      app: :paypal_exporter,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PaypalExporter.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.2"},
      {:httpoison, "~> 1.6"},
      {:poison, "~> 4.0"},
      {:quantum, "~> 2.3"},
      {:google_api_storage, "~> 0.16.0"},
      {:goth, "~> 1.1.0"},
      {:nimble_csv, "~> 0.7.0"}
    ]
  end
end
