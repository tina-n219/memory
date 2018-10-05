defmodule Memory.Agent do
  use GenServer

  def setup do
    {:ok, _} = Registry.start_link(keys: :unique, name: Memory.Registry)

    {:ok, _} = DynamicSupervisor.start_link(
      strategy: :one_for_one, name: Memory.Sup)
  end

  def reg(id) do
    {:via, Registry, {Memory.Registry, id}}
  end
  
    def start_link(game) do
      GenServer.start_link(__MODULE__, game)
    end

    def push(name, val) do
    end
  
    def get() do
      Genserver.get(__MODULE__, &(&1))
    end
  end
  