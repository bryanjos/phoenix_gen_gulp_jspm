defmodule PhoenixGenGulpJspm.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_gen_gulp_jspm,
     version: "1.0.0",
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

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:phoenix, "~> 1.0"}]
  end
end
