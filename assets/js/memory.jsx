import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
    ReactDOM.render(<Board />, root);
  }

  class Board extends React.Component {
    constructor(props) {
        super(props)
        let values = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
        this.state = { score: 0, 
                       gameOver: false, 
                       pairs: _.shuffle(_.concat(values, values)),
                       cards: this.generateBoard(),
                       
                    }
    };

    generateBoard() {
    let column = [];
        for(let i = 0; i < 16; i++) {
          column.push(
            this.generateCardData())
        }
      return column
    }

    generateCardData() {
        for (let i = 0; i < 4; i++) {
            for (let j = 0; j < 4; j++) {
                var grabNum = 4*i+j;
            } 
        }
        const uuidv1 = require('uuid/v1'); //Generates random id
        let values = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
        let cardValues = _.shuffle(_.concat(values, values))
        var card = {
            value: cardValues[grabNum],
            selected: true,
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
            return <Card data={card}/>;
        });
        
    return <div className="column-pairs">
       {board}
       </div>
    }
}


  function Card(props) {
    let cardData = props.data;
    let value = <p>{cardData.value}</p>;

    if (cardData.matched) {
        return <button>{value}</button>;
    }
    if (cardData.selected) {
        return <button>{value}</button>;
    }

    if (!cardData.selected) {
        return <button>?</button>;
    }
    return;


  }