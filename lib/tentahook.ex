defmodule Tentahook do

  @doc false
  defmacro __using__(_) do
    quote location: :keep do
      @behaviour Tentahook.Callbacks
    end
  end

  def start_link(handler) do
    child = Plug.Adapters.Cowboy.child_spec(:http, Tentahook.DI, [handler: handler], [])
    opts = [strategy: :one_for_one]
    Supervisor.start_link [child], opts
  end

end
