defmodule KlaviyoClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :klaviyo_client,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:antl_http_client,
       git: "https://github.com/annatel/antl_http_client.git", branch: "feat/get_method"}
      # {:antl_utils_ecto, "~> 2.8"},
      # {:antl_utils_elixir, "~> 1.4"},
      # {:bypass, "~> 2.1.0", only: :test},
      # {:hammox, "~> 0.5", only: :test}
    ]
  end
end
