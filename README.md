# Tentahook

Elixir handler for GitHub Webhooks.

## Installation

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

## Usage

Check this [example](https://github.com/Marqin/tentahook_example).

To start:
```elixir
Tentahook.start_link(tentahook_opts, cowboy_opts)
```

If `cowboy_opts` is empty then default port is 4000 (and all available IPs).
[More info about `cowboy_opts`.](https://hexdocs.pm/plug/Plug.Adapters.Cowboy.html)

To set new Tentahook config:

```elixir
Tentahook.reset_conf(tentahook_opts)
```

Available keys in config:

* handler - **mandatory**, handler which implements `handle_webhook` callback.
* secrets - list of GitHub secrets.
* unsafe - set this to `true` and secrets to `[]` if you don't want to validate
incoming payloads.
