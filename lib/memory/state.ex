defmodule Memory.State do

    def new() do 
        %{
            board: gen_board(),
            flipped: [],
            score: 0
        }
    end

    def gen_board() do
        values = ['a', 'a', 'b', 'b', 'c', 'c', 'd', 'd', 'e', 'e', 'f', 'f', 'g', 'g', 'h', 'h'];

        values
        |> Enum.shuffle()
        |> Enum.with_index
        |> Enum.map( fn(card) ->
            %{
                value: elem(card, 0),
                cardID: elem(card, 1),
                selected: false,
                matched: false
            }
        end)
        
    end

    def client_view(game) do 
        %{
            skel: skeleton(game.board), 
            score: 0
        }
    end

    def skeleton(cardList) do
        Enum.map cardList, fn card ->
            if (card.selected || card.matched) do
                card.value
            else 
                "-?-"
            end
        end 
    end

    def guess(game, cardIndex) do
        updateBoard = game.board;
        cardSelected = Enum.at(updateBoard, cardIndex);
        flippedList = game.flipped;

        gameScore = game.score;

        if (length(flippedList) < 2) do 
           flippedList = flippedList ++ cardSelected;
           cardSelected = %{cardSelected | selected: true}
           Map.put(game, :board, updateBoard)
        end

        if (length(flippedList) == 2) do
            cardOne = Enum.at(flippedList, 0);
            cardTwo = Enum.at(flippedList, 1);
        
            if (cardOne.value == cardTwo.value && !cardOne.matched && !cardTwo.matched) do
                cardOne = %{cardOne | selected: false, matched: true}
                cardTwo = %{cardTwo | selected: false, matched: true}
            
            else
                Process.sleep(5000);
                cardOne = %{cardOne | selected: false, matched: false}
                cardTwo = %{cardTwo | selected: false, matched: false}
                
            end
            Map.put(game, :board, updateBoard)
        end
        gameScore = gameScore + 1;
    end

end