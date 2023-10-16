defmodule KlaviyoApiClient.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :klaviyo_api_client,
      version: version(),
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:antl_http_client, git: "https://github.com/annatel/antl_http_client.git"},
      {:antl_utils_ecto, "~> 2.8"}
      # {:antl_utils_elixir, "~> 1.4"},
      # {:bypass, "~> 2.1.0", only: :test},
      # {:hammox, "~> 0.5", only: :test}
    ]
  end

  defp aliases do
    [
      "app.version": &display_app_version/1
    ]
  end

  defp version(), do: @version
  defp display_app_version(_), do: Mix.shell().info(version())
end
