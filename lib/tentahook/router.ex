defmodule Tentahook.Router do
  @moduledoc false

  use Plug.Router

  plug Tentahook.Verify
  plug :match
  plug :dispatch

  forward "/", to: Tentahook.RouterForVerified
end
