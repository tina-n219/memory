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
        cardlist = "aabbccddeeffgghh"

        cardlist
        |> String.graphemes()
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
    # def skeleton(cardlist) do
    #     Enum.map cardlist, fn card ->
    #        if (card.flipped || card.paired) do
    #         card.value
    #        else
    #         "?"
    #        end
    #     end
    # end


    def guess(game, cardIndex) do
        newBoard = game.board
        cardSelected = Enum.at(newBoard,cardIndex)
            newClickCount = game.clickCount + 1
            gametemp = Map.put(game, :clickCount, newClickCount)
            newCards = Enum.map(newBoard, fn(card) ->
            if (card.index == cardIndex) do
                %{card | flipped: true}
            else
                card
            end
        end)
        Map.put(gametemp, :board, newCards)

        #Process.sleep(5000)
    end

    def client_view(game) do
       %{
           skel: game.board,
           clickCount: game.clickCount
       }
    end

    def restart() do   
    end

end