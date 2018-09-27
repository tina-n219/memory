import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
    ReactDOM.render(<Board />, root);
  }

  class Board extends React.Component {
    constructor(props) {
        super(props)
        this.state = { score: 0, 
                       gameOver: false, 
                       cards: this.generateBoard(),  
                    }
    };

    generateBoard() {
    let column = [];
    let thisAnnoying = _.shuffle(['a', 'a', 'b', 'b', 'c', 'c', 'd', 'd', 'e', 'e', 'f', 'f', 'g', 'g', 'h', 'h']);
    console.log(thisAnnoying)
        for(let i = 0; i < 16; i++) {
          column.push(
            this.generateCardData(thisAnnoying, i))
        }
      return column
    }

    generateCardData(list, i) {
        console.log("IN " + list);
        const uuidv1 = require('uuid/v1'); //Generates random id

        var card = {
            value: list[i],
            selected: false,
            matched: false,
            cardID: uuidv1(),
        }
        return card;
    }

    render() { 
        let score = <div className="column">
            Score: {this.state.score}
        </div>
        let restart = <div className="column">
            <button class="button button-outline">Restart</button>
        </div>
        console.log(this.state)
        console.log(this.state.cards[0])

        let board = _.map(this.state.cards, (card) => {
            return <Card data={card} buttoncall={this.click.bind(this)}/>;
        });
        
    return <div className="column-pairs">
       {board}
       <button class="button button-outline" onClick={this.reset.bind(this)}>Reset</button>
       Score: {this.state.score}
       </div>
    }

    click(cardID) {
        
        let updateCards = _.map(this.state.cards, (card) => {
            if(card.cardID === cardID) {
                card.selected = true;
            }
            return card;
        });


        let updateScore = this.state.score;
        this.setState({
            score: updateScore + 1,
            cards: updateCards
        });
    }

    reset() {
        console.log("HERE");
        this.setState({
            score: 0,
            cards: this.generateBoard()
        });
        
    }
}


  function Card(props) {
    let cardData = props.data;
    let value = <p>{cardData.value}</p>;
    let cardNum = cardData.cardID;

    if (cardData.matched) {
        return <button onClick={() => props.buttoncall(cardNum)}>{value}</button>;
    }
    if (cardData.selected) {
        return <button onClick={() => props.buttoncall(cardNum)}>{value}</button>;
    }

    if (!cardData.selected) {
        return <button onClick={() => props.buttoncall(cardNum)}>?</button>;
    }
    return;


  }