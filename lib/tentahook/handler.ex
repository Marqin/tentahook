defmodule Tentahook.Handler do

  def handle(conn) do
    raw_body = conn.private[:raw_body]
    content_type = List.first Plug.Conn.get_req_header(conn, "content-type")

    json_data = case content_type do
      "application/x-www-form-urlencoded" ->
        Plug.Conn.Utils.validate_utf8!(raw_body, Plug.Parsers.BadEncodingError, "urlencoded body")
        Plug.Conn.Query.decode(raw_body) |> Map.get("payload", "")
      "application/json" -> raw_body
      _ -> ""
    end

    data = case Poison.decode(json_data) do
      {:ok, json} ->
        if Kernel.is_map json do
          json
        else
          nil
        end
      {:error, _} -> nil
    end

    case data do
      nil ->
        false
      _ ->
        # handling webhook data is side-effect for our server
        # so we run it out of our supervision tree
        # IDEA: make another supervisor for hooks?
        Task.start(fn -> handle_data(conn.private[:handler], data) end)
        true
    end
  end

  def handle_data(handler, data) do
    handler.handle_webhook(data)
  end
end
