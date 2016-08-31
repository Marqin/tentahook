defmodule Tentahook.DI do

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    conn = Plug.Conn.put_private(conn, :handler, opts[:handler])
    Tentahook.Router.call(conn, opts)
  end
end
