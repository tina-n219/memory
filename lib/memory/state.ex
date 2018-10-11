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
        IO.puts"======= CARDS SELECTED ATM"
        IO.inspect(length(selectedCards))
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
        oneFlipBoard = Enum.map(allCards, fn (card) -> 
            if(card.cardID == cardIndex) do
                %{card | selected: true}
            else 
                card
            end
        end)
        newBoard = Map.put(game, :board, oneFlipBoard)

        selectedCards = Enum.filter(newBoard.board, fn(card) -> card.selected == true and card.matched != true end)
        numSelected = length(selectedCards)
        
        # Check if it's first or second card being selected
        if (numSelected < 2) do
            {:firstguess, newBoard}
        else 
            if (checkMatch(newBoard, selectedCards)) do 
                IO.puts"This was an successful try, time to tell the server"
                {:correctguess, newBoard}
            else
                IO.puts"This was an unsuccessful try, time to tell the server"
                {:incorrectguess, newBoard}
            end
        end

    end

    def finish_successful(game) do
        # change the score 
        # get the non last player
        user = getNoneLast(game)
        newLastPlayer = Map.put(game, :lastPlayer, user)

        newPlayers = Enum.map(newLastPlayer.players, fn (player) ->
            if (player.username == user) do
                %{player | score: player.score + 1}
            end
        end)
        updatedScore = Map.put(newLastPlayer, :players, newPlayers)

        # match cards
        selectedCards = Enum.filter(updatedScore.board, fn(card) -> card.selected == true and card.matched != true end)
        
        cardOne = Enum.at(selectedCards, 0)
        cardTwo = Enum.at(selectedCards, 1)
        IO.inspect(cardOne)
        IO.inspect(cardTwo)
        matchCardOne = Enum.map(updatedScore.board, fn (card) -> 
            if(card.value == cardOne.value) do 
                %{card | matched: true, selected: false}
            else 
                card
            end
        end)
        matchBoard = Map.put(updatedScore, :board, matchCardOne)

        matchCardTwo = Enum.map(matchBoard.board, fn (card) -> 
            if(card.value == cardTwo.value) do
                    %{card | matched: true, selected: false}
                else 
                       card
                    end
               end)
        IO.inspect(matchCardTwo)
        Map.put(matchBoard, :board, matchCardTwo)
    end

    def finish_unsuccessful(game) do
        IO.puts"last player before changing"
        dude = game.lastPlayer
        IO.inspect(dude)
            unselectCards = Enum.map(game.board, fn (card) -> 
                if (card.selected) do
                    %{card | selected: false}
                else
                    card
                end
            end)
            matchBoardLast = Map.put(game, :board, unselectCards)
            # change the turn 
            newLastUser = getNoneLast(matchBoardLast)

            Map.put(matchBoardLast, :lastPlayer, newLastUser)
     end

     def getNoneLast(game) do
        newplayer = nil
        currentLast = game.lastPlayer
        all = game.players
        player1 = Enum.at(all, 0)
        player2 = Enum.at(all, 1)
        if (player1.username == currentLast) do
            newplayer = player2.username
        end
        if (player2.username == currentLast) do
            newplayer = player1.username
        end
        #  onePlayer = Enum.map(game.players, fn (player) -> 
        #     if (currentLast.username != player.username) do
        #         player
        #     end
        # end)
        #newPlayer = Enum.at(onePlayer, 0)
        Map.put(game, :lastPlayer, newplayer)

     end

    # Check if the cards selected are a match
    #  Return a boolean if they're matched
    def checkMatch(newBoard, selectedCards) do
        #make sure indecxs are not the same
        cardOne = Enum.at(selectedCards, 0)
        cardTwo = Enum.at(selectedCards, 1)
        cardOne.value == cardTwo.value and cardOne.cardID != cardTwo.cardID
    end

end