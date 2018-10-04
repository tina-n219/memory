defmodule Memory.Game do
   # use GenServer

    # def setup do
    #   {:ok, _} = Registry.start_link(keys: :unique, name: Memory.Registry)
  
    #   {:ok, _} = DynamicSupervisor.start_link(
    #     strategy: :one_for_one, name: Memory.Sup) 
    # end

    # def reg(id) do
    #     {:via, Registry, {Memory.Registry, id}}
    # end

    # def start(id) do
    #     spec = %{
    #       id: __MODULE__,
    #       start: {__MODULE__, :start_link, [id]},
    #       restart: :permanent,                         
    #       type: :worker,                              
    #     }
    #     DynamicSupervisor.start_child(Memory.Sup, spec)
    #   end
    
    # def start_link(id) do
    #     GenServer.start_link(__MODULE__, new(), name: reg(id))
    # end

    # def select_Card(id, cardID) do
    #     GenServer.call(reg(id), {:selected, cardID, id})
    # end

    # def client_view(id, game) do
    #     GenServer.call()
    # end

    # def handle_call(:select_Card, _from, id) do
    #     #{:reply, Memory.state....}
    # end


    # def client_view(game) do
    #     guess = game.

    #     %{
    #     skel: skeleton(board, guess)
    #     }    
    # end

    # def skeleton(board, guessIndex) do
    #     Enum.map word, fn cc ->
    #       if Enum.member?(guesses, cc) do
    #         cc
    #       else
    #         "_"
    #       end
    #     end
    #   end

    # def guess(game, letterIndex) do
    #     Map.put(game, :score, game.score + 1);
    #     numFlips = cardsSelected();
    #     matches = isMatch();
       

    #     if numFlips < 2 do
    #          # update guesses 
    #     end

    #     click(game, letterIndex, numFlips, isMatch);
    
    #     # gs = game.guesses
    #     # |> MapSet.new()
    #     # |> MapSet.put(letter)
    #     # |> MapSet.to_list
    
       
    # end  

    # def cardsSelected() do
    #     Game.flipped.length;
    #     # go through board and count selected cards
    # end

    # def isMatch() do
       
    #     # see if two cards match
    # end

    # def click(game, letterIndex, 2, true) do

    #     # mark as matched and display always
    # end

    # def click(game, letterIndex, 2, false) do
    #     # flip back with delay
    # end

    # def click(game, letterIndex, 1, false) do
        
    # end

end