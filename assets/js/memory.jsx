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

        let row1 = _.map(this.state.cards[0], (card) => {
            return <Card data={card}/>;
        });
        let row2 = _.map(this.state.cards[1], (card) => {
            return <Card data={card}/>;
        });
        let row3 = _.map(this.state.cards[2], (card) => {
            return <Card data={card}/>;
        });
        let row4 = _.map(this.state.cards[3], (card) => {
            return <Card data={card}/>;
        });
    return <div className="column-pairs">
       {row1}
       {row2}
       {row3}
       {row4}
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