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
    const column = [];
        for(let i = 0; i < 4; i++) {
          const row = [];
          for (let j = 0; j < 4; j++) {
              row.push(
                this.generateCard())
                }
            column.push({row});
      }
      return {column}
    }

    generateCard() {
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
            selected: false,
            matched: false,
            cardID: uuidv1(),
        }
        return card;
    }

    render() {
        console.log(this.state.cards);
        console.log(this.state.pairs);
        let score = <div className="column">
            Score: {this.state.score}
        </div>

        let restart = <div className="column">
            <button class="button button-outline">Restart</button>
        </div>
        
        return 
        <div className="column">
       {score} {restart}
       </div>
    }
}


  function Card(props) {
    let value = <div className="column"> 
    <p>{props.value}</p>
    </div>

    if (props.matched) {
        return <button>{value}</button>;
    }
    if (props.selected) {
        return <button>{value}</button>;
    }

    if (!props.selected) {
        return <button>?</button>;
    }
    return;


  }