defmodule Tentahook.DI do

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    conn = Plug.Conn.put_private(conn, :handler, opts[:handler])
    conn = Plug.Conn.put_private(conn, :secrets, opts[:secrets])
    conn = Plug.Conn.put_private(conn, :unsafe, opts[:unsafe])
    Tentahook.Router.call(conn, opts)
  end
end
