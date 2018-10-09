defmodule Memory.State do

    def new() do 
        %{
            board: gen_board(),
            score: 0
        }
    end

    def gen_board() do
        whydontyouwork = ["a", "a", "b", "b", "c", "c", "d", "d", "e", "e", "f", "f", "g", "g", "h", "h"];
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

    def client_view(game) do 
        %{
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
    # end

    def guess(game, cardIndex) do
        updateBoard = game.board;
        updatedScore = game.score + 1;

        Map.put(game, :score, updatedScore);
        
        # cardSelected = Enum.at(updateBoard, cardIndex);

        # selected = Enum.filter(game.board, fn card ->
        #     card.selected == true
        # end)

        # if (length(selected) < 2) do 
        #     Enum.map(updateBoard, fn (card) ->
        #         if(card.cardID == cardIndex) do
        #            #Map.put(card, :selected, true)
        #            card = %{card | selected: true}
        #         end
        #     end)
        #     Map.put(game, :board, updateBoard)
        # end
        #end

        # if (length(flippedList) == 2) do
        #     cardOne = Enum.at(flippedList, 0);
        #     cardTwo = Enum.at(flippedList, 1);
        
        #     if (cardOne.value == cardTwo.value && !cardOne.matched && !cardTwo.matched) do
        #         cardOne = %{cardOne | selected: false, matched: true}
        #         cardTwo = %{cardTwo | selected: false, matched: true}
            
        #     else
        #         Process.sleep(5000);
        #         cardOne = %{cardOne | selected: false, matched: false}
        #         cardTwo = %{cardTwo | selected: false, matched: false}
                
        #     end
        #     Map.put(game, :board, updateBoard)
        # end
        
    end

end