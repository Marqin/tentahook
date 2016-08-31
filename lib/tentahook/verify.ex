defmodule Tentahook.Verify do

  def init([]), do: false

  def call(conn, _) do
    {:ok, raw_body, conn} = Plug.Conn.read_body(conn)
    conn = Plug.Conn.put_private(conn, :raw_body, raw_body)

    secret_key = Application.get_env(:tentahook, :secret)

    if secret_key && secret_key != "" do
      hash = :crypto.hmac(:sha, secret_key, raw_body) |> Base.encode16 |> String.downcase
      sig =
        Plug.Conn.get_req_header(conn, "x-hub-signature")
        |> List.to_string |> String.slice(5..-1)

      if hash != sig do
        conn |> Plug.Conn.send_resp(401, "Unauthorized") |> Plug.Conn.halt
      else
        conn
      end
    else
      if conn.private[:unsafe] do
        conn
      else
        conn |> Plug.Conn.send_resp(401, "Unauthorized") |> Plug.Conn.halt
      end
    end
  end

end
