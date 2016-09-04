defmodule Tentahook.Mixfile do
  use Mix.Project

  def project do
    [app: :tentahook,
     version: "0.1.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Elixir handler for GitHub Webhooks.",
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:cowboy, :plug, :logger]]
  end

  defp deps do
    [{:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.0"},
     {:poison, "~> 2.0"},
     {:ex_doc, "~> 0.12", only: :dev}]
  end

  defp package do
  [
   name: :tentahook,
   files: ["lib", "mix.exs", "README.md", "LICENSE"],
   maintainers: ["Hubert Jarosz"],
   licenses: ["Zlib"],
   links: %{"GitHub" => "https://github.com/Marqin/tentahook"}]
  end
end
