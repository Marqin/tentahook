defmodule Tentahook do

  @doc false
  defmacro __using__(_) do
    quote location: :keep do
      @behaviour Tentahook.Callbacks
    end
  end

  def start_link(tentahook_opts = %{handler: _handler}, cowboy_opts) do
    Agent.start_link(fn -> tentahook_opts end, name: Tentahook)

    child = Plug.Adapters.Cowboy.child_spec(:http, Tentahook.Router, [], cowboy_opts)
    opts = [strategy: :one_for_one]
    Supervisor.start_link [child], opts
  end

  def reset_conf(tentahook_opts = %{handler: _handler}) do
    Tentahook.Conf.reset(tentahook_opts)
  end

end
