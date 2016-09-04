defmodule Tentahook.Conf do
  @moduledoc false

  @spec get(atom) :: any
  def get(key) do
    Agent.get(Tentahook, fn map -> map[key] end)
  end

  @spec reset(map) :: any
  def reset(new_conf) do
    Agent.get_and_update(Tentahook, fn _ -> {nil, new_conf} end)
  end

end
