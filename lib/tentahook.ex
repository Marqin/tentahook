defmodule Tentahook do
  @moduledoc """
  Elixir handler for GitHub Webhooks.

  Your module must have `use Tentahook` clause and implement all callbacks from
  `Tentahook.Callbacks`. Then you can start it via `start_link/2`.
  """

  @doc false
  defmacro __using__(_) do
    quote location: :keep do
      @behaviour Tentahook.Callbacks
    end
  end

  @doc """
  Starts Tentahook in current supervision tree.

  ## Parameters

  * tehntahook_opts - Tentahook options
  * cowboy_opts - [Cowboy options](https://hexdocs.pm/plug/Plug.Adapters.Cowboy.html)

  Supported Tentahook options:

  * handler - **mandatory**, handler which implements `handle_webhook` callback
  * secrets - list of GitHub secrets
  * unsafe - set this to `true` and secrets to `[]` if you don't want to validate
  incoming payloads.

  It will return the same values as
  [`Supervisor.start_link`](http://elixir-lang.org/docs/stable/elixir/Supervisor.html#start_link/2).
  """
  def start_link(tentahook_opts = %{handler: _handler}, cowboy_opts) do
    Agent.start_link(fn -> tentahook_opts end, name: Tentahook)

    child = Plug.Adapters.Cowboy.child_spec(:http, Tentahook.Router, [], cowboy_opts)
    opts = [strategy: :one_for_one]
    Supervisor.start_link [child], opts
  end

  @doc """
  Resets Tentahook configuration.

  ## Parameters

  * tehntahook_opts - new Tentahook options

  Supported tehntahook_opts are the same as in `start_link/2` and `handler` is
  also mandatory here (and yes, it can change).

  Returns `:ok`
  """
  def reset_conf(tentahook_opts = %{handler: _handler}) do
    Tentahook.Conf.reset(tentahook_opts)
    :ok
  end

end
