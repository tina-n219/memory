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
        # Is it this user's turn?
        selectedCards = Enum.filter(game.board, fn(card) -> card.selected == true end)
        if (user == game.lastPlayer || length(selectedCards) >= 2) do
            IO.inspect(user)
            IO.inspect(selectedCards)
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
        oneFlipBoard = Enum.map(allCards, fn (card) -> 
            if(card.cardID == cardIndex) do
                %{card | selected: true}
            else 
                card
            end
        end)
        newBoard = Map.put(game, :board, oneFlipBoard)

        selectedCards = Enum.filter(newBoard.board, fn(card) -> card.selected == true end)
        numSelected = length(selectedCards)
        
        # Check if it's first or second card being selected
        if (numSelected < 2) do
            {:firstguess, newBoard}
        else 
            IO.inspect(newBoard)
            IO.inspect(selectedCards)
            if (checkMatch(newBoard, selectedCards)) do 
                IO.puts"This was an succesful try, time to tell the server"
                {:correctguess, newBoard}
            else
                IO.puts"This was an unsuccesful try, time to tell the server"
                {:incorrectguess, newBoard}
            end
        end

    end

    def finish_succesful(game) do
        # change the score 

        # get the non last player
        user = "catu"

        newPlayers = Enum.map(game.players, fn (player) ->
            if (player.username == user) do
                %{player | score: player.score + 1}
            end
        end)
        updatedScore = Map.put(game, :players, newPlayers)

        # match cards
        selectedCards = Enum.filter(updatedScore.board, fn(card) -> card.selected == true end)
        cardOne = Enum.at(selectedCards, 0)
        cardTwo = Enum.at(selectedCards, 1)
        matchCardOne = Enum.map(updatedScore.board, fn (card) -> 
            if(card.value == cardOne) do 
                %{card | matched: true}
                %{card | selected: false}
            else 
                card
            end
        end)
        matchBoard = Map.put(updatedScore, :board, matchCardOne)

        matchCardTwo = Enum.map(matchBoard, fn (card) -> 
            if(card.value == cardTwo) do
                    %{card | matched: true}
                    %{card | selected: false}
                else 
                       card
                    end
               end)
        matchBoardLast = Map.put(matchBoard, :board, matchCardTwo)

        # change the turn 
        Map.put(matchBoardLast, :lastPlayer, user)
    end

    def finish_unsuccesful(game) do
        IO.puts"This was an unsuccesful try and the state"
        selectedCards = Enum.filter(game.board, fn(card) -> card.selected == true end)
        cardOne = selectedCards[0]
        cardTwo = selectedCards[1]
              # unselect cards
              matchCardOne = Enum.map(game.board, fn (card) -> 
                if(card.value == cardOne) do 
                    %{card | selected: false}
                else 
                    card
                end
            end)
            matchBoard = Map.put(game, :board, matchCardOne)
    
            matchCardTwo = Enum.map(matchBoard, fn (card) -> 
                if(card.value == cardTwo) do
                        %{card | selected: false}
                    else 
                           card
                        end
                   end)
            matchBoardLast = Map.put(matchBoard, :board, matchCardTwo)
    
            # change the turn 
            user = "catu"

            Map.put(matchBoardLast, :lastPlayer, user)
     end

    # Check if the cards selected are a match
    #  Return a boolean if they're matched
    def checkMatch(newBoard, selectedCards) do
        #make sure indecxs are not the same
        cardOne = Enum.at(selectedCards, 0)
        cardTwo = Enum.at(selectedCards, 1)
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