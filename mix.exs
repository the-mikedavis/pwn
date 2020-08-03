defmodule Pwn.MixProject do
  use Mix.Project

  def project do
    [
      app: :pwn,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [bless: :test],
      test_coverage: [tool: ExCoveralls],
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:bless, "~> 1.0", only: :test},
      {:excoveralls, "~> 0.11", only: :test},
      {:credo, "~> 1.4", only: :test}
    ]
  end
end
