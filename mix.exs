defmodule Game_2048.Mixfile do
  use Mix.Project

  def project do
    [app: :game_2048,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
