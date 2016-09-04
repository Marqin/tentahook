defmodule Tentahook.Callbacks do
  @moduledoc """
  Callbacks that every project that `use Tentahook` must implement.
  """

  @doc """
  Callback for webhooks.

  It's single argument will be map containing GitHub webhook.
  More info can be found [here](https://developer.github.com/webhooks/#payloads).

  It's return value will be discarded.
  """
  @callback handle_webhook(map) :: any

end
