defmodule Memory.Game do

    def new() do        
        %{
            board: createBoard(),
            clickCount: 0,
            firstCardClickedIndex: -1,
            gameWon: false,
        }
    end

    def createBoard() do
        cardlist = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h','a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
      
        cardlist
        |> Enum.shuffle()
        |> Enum.with_index
        |> Enum.map( fn(x) ->
            %{
                index: elem(x, 1),
                value: elem(x, 0),
                flipped: false,
                paired: false
            }
        end)    
    end

    # Show if it is selected or matched 
    def skeleton(cardlist) do
        Enum.map cardlist, fn card ->
           if (card.flipped || card.paired) do
            card.value
           else
            "?"
           end
        end
    end

    def updateCard(card) do
        card= %{
            index: card.index,
            value: card.value,
            flipped: true,
            paired: false
        }
    end

    def guess(game, cardIndex) do

        newBoard = game.board
        newClickCount = game.clickCount + 1
        cardSelected = Enum.at(newBoard,cardIndex)
        cardSelected = %{cardSelected | flipped: true}


        # update the board
        gametemp = Map.put(game, :clickCount, newClickCount)
        Map.put(gametemp, :board, newBoard)


        #if the click count is odd, just update the firstCardClickedIndex
        #     attemptedCard = Enum.at(game.board,cardIndex)

    #     #  if the card flipped / paired, don't count click
    #     if (attemptedCard.flipped || attemptedCard.paired) do 
    #     else 
    #     newBoard = game.board
    #     # increase click count 
    #     newClickCount = newBoard.clickCount + 1      
    #     # flip the card
    #     cardSelected = Enum.at(newBoard,cardIndex)
    #     cardSelected = %{cardSelected | flipped: true}
    #     # update the board
    #     Map.put(game, :board, newBoard, :clickCount, newClickCount)
    #     # Wait 5 seconds and check if the cards are equal
    #     Process.sleep(5000)
    #     priorCard = game.firstCardClickedIndex
    #     newBoard2 = game.board

    #     if (priorCard > 0 && rem(newClickCount, 2) == 0) do
            
    #         # Check if values are equal 
    #         firstCardflipped = Enum.at(newBoard2,priorCard)
    #         cardflipped = Enum.at(newBoard2,cardIndex)


    #         if (firstCardflipped.value == cardflipped.value) do


    #             # So if the values are equal, flip and pair both of them
    #             cardflipped = %{cardflipped | paired: true}
    #             firstCardflipped = %{firstCardflipped | paired: true}
          
    #             # if the values are not equal, unflip them
    #         else 
    #             cardflipped = %{cardflipped | flipped: false}
    #             firstCardflipped = %{firstCardflipped | flipped: false}
    #         end

    #         # Update the board
    #         #Map.put(game, :board, newBoard2)    

    #     else
    #         # if the click count is odd, just update the firstCardClickedIndex
    #         #Map.put(game, :firstCardClickedIndex, cardIndex) 
    #     end
    # end

    end

    def client_view(game) do
        cards = game.board
        clicks = game.clickCount
       %{
           skel: cards,
           clickCount: clicks
       }
    end

    def restart() do
        
    end

end