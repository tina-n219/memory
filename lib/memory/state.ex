defmodule Memory.State do

    def new() do 
        %{
            board: gen_board(),
            clickCount: 0,
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
          clickCount: 0
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
            clickCount: game.clickCount,
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
        IO.puts"Are we allowing guessing? yea boi"
        # Is it this user's turn?
        selectedCards = Enum.filter(game.board, fn(card) -> card.selected == true end)
        if (user == game.lastPlayer || length(selectedCards) >= 2) do
            {:invalid, game}
        else
            # If it's a valid click, allow it
            cardSelected = Enum.at(game.board, cardIndex)
            if (!cardSelected.selected and !cardSelected.matched) do
                allowClick(game, cardIndex)
            else
                game
            end 
        end
    end

    # User valid click
     def allowClick(game, cardIndex) do
        updateBoard = game.board
        updatedclickCount = game.clickCount + 1
        Map.put(game, :clickCount, updatedclickCount)
        newBoard = game
        # Get list of selected cards 
        allCards = newBoard.board
        selectedCards = Enum.filter(allCards, fn(card) -> card.selected == true end)
        numSelected = length(selectedCards)

        oneFlipBoard = Enum.map(allCards, fn (card) -> 
            if(card.cardID == cardIndex) do
                %{card | selected: true}
            else 
                card
            end
        end)
        newBoard = Map.put(game, :board, oneFlipBoard)
        
        # Check if it's first or second card being selected
        if (numSelected < 2) do
            {:firstguess, newBoard}
        else 
            if (checkMatch(newBoard, selectedCards)) do 
                {:correctguess, newBoard}
            else
                {:incorrectguess, newBoard}
            end
        end

    end

    def finish_succesful(game) do
       # if they aren't a match
       # change the score if they are 
       # change the turn 
    end

    def finish_unsuccesful(game) do
        # if they aren't a match
        # change the turn 
     end

    # Check if the cards selected are a match
    #  Return a boolean if they're matched
    def checkMatch(newBoard, selectedCards) do
        #make sure indecxs are not the same
        cardOne = selectedCards[0]
        cardTwo = selectedCards[1]
        cardOne.value == cardTwo.value and cardOne.cardID != cardTwo.cardID
    end
        # result = false

        # if (cardOne == cardTwo) do
        #     # The cards are equal so set as match
        #     matchOne = Enum.map(newBoard, fn (card) -> 
        #         if(card.value == cardOne) do
        #             %{card | matched: true}
        #             %{card | selected: false}
        #            else 
        #                card
        #            end
        #        end)
        #        matchBoard = Map.put(newBoard, :board, matchOne)

        #        matchTwo = Enum.map(matchBoard, fn (card) -> 
        #         if(card.value == cardTwo) do
        #             %{card | matched: true}
        #             %{card | selected: false}
        #         else 
        #                card
        #             end
        #        end)
        #        Map.put(newBoard, :board, matchTwo)
        #     else 
        #         # The cards are not equal so flip back
        #         matchOne = Enum.map(newBoard, fn (card) -> 
        #             if(card.value == cardOne) do
        #                 %{card | selected: false}
        #                else 
        #                    card
        #                end
        #            end)
        #            matchBoard = Map.put(newBoard, :board, matchOne)
    
        #            matchTwo = Enum.map(matchBoard, fn (card) -> 
        #             if(card.value == cardTwo) do
        #                 %{card | selected: false}
        #             else 
        #                    card
        #                 end
        #            end)
        #            Map.put(newBoard, :board, matchTwo)
        #     end
    #end

end