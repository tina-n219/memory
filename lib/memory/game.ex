defmodule Memory.Game do
 use GenServer

    def setup do
      {:ok, _} = Registry.start_link(keys: :unique, name: Memory.Registry)
  
      {:ok, _} = DynamicSupervisor.start_link(
        strategy: :one_for_one, name: Memory.Sup) 
    end

    def reg(id) do
        {:via, Registry, {Memory.Registry, id}}
    end

    def start(id) do
        spec = %{
          id: __MODULE__,
          start: {__MODULE__, :start_link, [id]},
          restart: :permanent,                         
          type: :worker,                              
        }
        DynamicSupervisor.start_child(Memory.Sup, spec)
      end
    
    def start_link(game) do
        GenServer.start_link(__MODULE__, game)
    end

    def guess(id, cardIndex) do
        GenServer.call(reg(id), {:guess, cardIndex})
    end

    def client_view(id) do
        GenServer.call(reg(id), :client_view)
    end

    def handle_call(:guess, _from, cardIndex) do
        {:noreply, Memory.State.guess(_from, cardIndex)}
    end

    def handle_call(:client_view, _from, game) do
        
    end
end