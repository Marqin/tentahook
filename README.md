# Tentahook

Elixir handler for GitHub Webhooks.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `tentahook` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:tentahook, "~> 0.1.0"}]
    end
    ```

  2. Ensure `tentahook` is started before your application:

    ```elixir
    def application do
      [applications: [:tentahook]]
    end
    ```
