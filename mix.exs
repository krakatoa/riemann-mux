defmodule RiemannMux.Mixfile do
  use Mix.Project

  def project do
    [app: :riemann_mux,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:logger, :gun, :cowboy],
      mod: {RiemannMux, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:cowboy, git: "https://github.com/ninenines/cowboy", tag: "2.0.0-pre.10"},
      {:gun, git: "https://github.com/ninenines/gun"},
      {:ranch, "~> 1.4", override: true}
    ]
  end
end
