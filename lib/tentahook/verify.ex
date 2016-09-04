defmodule Tentahook.Verify do
  @moduledoc false

  def init([]), do: false

  def call(conn, _opts) do
    {:ok, raw_body, conn} = Plug.Conn.read_body(conn)
    conn = Plug.Conn.put_private(conn, :raw_body, raw_body)

    sig =
      Plug.Conn.get_req_header(conn, "x-hub-signature")
      |> List.to_string |> String.slice(5..-1)

    secrets = Tentahook.Conf.get(:secrets)

    IO.inspect secrets

    if secrets && secrets != [] do
      if check_loop(raw_body, sig, secrets) do
        conn
      else
        conn |> Plug.Conn.send_resp(401, "Unauthorized") |> Plug.Conn.halt
      end
    else
      unsafe = Tentahook.Conf.get(:unsafe)
      if unsafe do
        conn
      else
        conn |> Plug.Conn.send_resp(401, "Unauthorized") |> Plug.Conn.halt
      end
    end
  end

  def check_loop(_body, _sig, []) do
    false
  end

  def check_loop(body, sig, [secret|tail]) do
    if check(body, sig, secret) do
      true
    else
      check_loop(body, sig, tail)
    end
  end

  def check(body, sig, secret) do
    hash = :crypto.hmac(:sha, secret, body) |> Base.encode16 |> String.downcase
    sig == hash
  end

end
