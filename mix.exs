defmodule PhoenixGenGulpJspm.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_gen_gulp_jspm,
     version: "0.3.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description,
     package: package,
     deps: deps]
  end

  defp description do
    """
    Replaces Brunch with Gulp and adds JSPM
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*", "CHANGELOG*"],
      contributors: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{ 
        "GitHub" => "https://github.com/bryanjos/phoenix_gen_gulp_jspm"
      },
      build_tools: ["mix"]
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:phoenix, "~> 1.0"}]
  end
end
