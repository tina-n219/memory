defmodule Memory.State do

    def new() do 
        %{
            board: gen_board(),
            score: 0,
            players: [],
            lastPlayer: nil
        }
    end

    def joinGame(game, user) do
        # check if user is not in the game and there is space for them
        # if there is, add them to this game's players
        currentPlayers = length(game.players) 
        if (Enum.member?(game.players, default_player(user)) == false and currentPlayers < 2) do
            newPlayers = (game.players ++ [default_player(user)])
            newGame = Map.put(game, :players, newPlayers)

            # If the list of players is at two, then add this user
            # as the latest player 
            if (length(newGame.players) == 2) do
                IO.puts"get here"
                Map.put(newGame, :lastPlayer, user)
            else
                newGame
            end
        else
            game
        end
    end

    # def gen_players() do
    #     %{
    #         :nattuck => "1"
    #     }
    # end

    def default_player(user) do
        player = %{
          username: user,
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
            skel: game.board, 
            score: game.score,
            players: game.players,
            lastPlayer: game.lastPlayer
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

    def guess(game, user, cardIndex) do


        updateBoard = game.board
        updatedScore = game.score + 1
        Map.put(game, :score, updatedScore)



        # cardSelected = Enum.at(updateBoard, cardIndex);

        # selected = Enum.filter(game.board, fn card ->
        #     card.selected == true
        # end)

        # # Here I am just trying to get this function to flip a card
        # # before I get the rest of the logic to work
        # # I am just trying to get some response from my front end
        # if (length(selected) < 2) do 
        #     newBoard = Enum.map(updateBoard, fn (card) ->
        #         if(card.cardID == cardIndex) do
        #            %{card | selected: true}
        #         else 
        #             card
        #         end
        #     end)
        #     Map.put(game, :board, newBoard)
        # end

        # if (length(selected) == 2) do
            
        # end
    end

end