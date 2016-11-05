defmodule ParadoxParser.Mixfile do
  use Mix.Project

  @version "1.0.0"

  def project do
    [app: :paradox_parser,
     version: @version,
     elixir: "~> 1.2 or ~> 1.3",
     name: "Paradox Parser",
     description: "A package to parse Clausewitz Engine games configuration and save files",
     deps: deps()]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  defp deps do
    [
        {:codepagex, "~> 0.1.3"}
    ]
  end
end
