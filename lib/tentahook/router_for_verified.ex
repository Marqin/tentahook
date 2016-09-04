defmodule Tentahook.RouterForVerified do
  @moduledoc false

  use Plug.Router

  plug :match
  plug :dispatch

  post "/" do
    if Tentahook.Handler.handle(conn) do
      send_resp(conn, 200, "")
    else
      send_resp(conn, 400, "Bad Request")
    end
  end

  get "/" do
    send_resp(conn, 405, "Method Not Allowed")
  end

  match _ do
    send_resp(conn, 404, "Not Found!")
  end
end
