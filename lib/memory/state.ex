defmodule Memory.State do

    def new() do 
        %{
            board: gen_board(),
            score: 0,
            players: gen_players()
        }
    end

    def joinGame(game, user) do
        # check if user is not in the game and there is space for them
        # if there is, add them to this game's players
        IO.puts"The user is trying to join the game"
        currentPlayers = length(Map.values(game.players))    
        IO.inspect(currentPlayers)    
        if (game.players[user] == nil and currentPlayers < 2) do
            newPlayers = Map.put(game.players, user, default_player)
            Map.put(game, :players, newPlayers)
        else
            game
        end
    end

    def gen_players() do
        %{}
    end

    def default_player() do
        %{
          turn: false,
          score: 0
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
        %{
            players: game.players,
            skel: game.board, 
            score: 0
        }

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