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
        GenServer.call(id)
    end

    # def select_Card(id, cardID) do
    #     GenServer.call(reg(id), {:selected, cardID, id})
    # end

    # def handle_call(:select_Card, _from, id) do
    #     #{:reply, Memory.state....}
    # end
end