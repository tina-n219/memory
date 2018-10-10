defmodule Memory.State do

    def new() do 
        %{
            board: gen_board(),
            score: 0,
            players: []
        }
    end

    def new(players) do
        players = Enum.map players, fn {name} ->
          {name, %{ default_player()}}
        end
        Map.put(new(), :players, Enum.into(players, %{}))
    end

    def default_player() do
        %{
          matches: MapSet.new(),
          turn: false,
          observer: false
        }
    end

    def gen_board() do
        ughAHH = "aabbccddeeffgghh"
        ughAHH
        |> String.graphemes()
        |> Enum.shuffle()
        |> Enum.with_index
        |> Enum.map( fn {letter, index} ->
            %{
                value: letter,
                cardID: index,
                selected: false,
                matched: false
            }
        end)
        
    end

    def client_view(game, user) do 
        if(game.players.length < 2) do
            %{
                skel: [], 
                score: 0
            }
        end
        if (game.players.length == 2) do
        %{
            skel: game.board, 
            score: 0
        }
    
        else 
            #make observers
        end

    end

    # def skeleton(cardList) do
    #     Enum.map cardList, fn card ->
    #         if (card.selected || card.matched) do
    #             card.value
    #         else 
    #             "-?-"
    #         end
    #     end 
    # end n

    def guess(game, cardIndex) do
        updateBoard = game.board;
        updatedScore = game.score + 1;

        cardSelected = Enum.at(updateBoard, cardIndex);

        selected = Enum.filter(game.board, fn card ->
            card.selected == true
        end)

        # Here I am just trying to get this function to flip a card
        # before I get the rest of the logic to work
        # I am just trying to get some response from my front end
        if (length(selected) < 2) do 
            newBoard = Enum.map(updateBoard, fn (card) ->
                if(card.cardID == cardIndex) do
                   %{card | selected: true}
                else 
                    card
                end
            end)
            Map.put(game, :board, newBoard)
        end

        if (length(selected) == 2) do
            
        end
    end

end