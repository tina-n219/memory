import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
    ReactDOM.render(<Board />, root);
  }

  // Represents the Memory Game
  // Keeps track of score via number of clicks on button
  // Holds an array of the values of the tiles
  class Board extends React.Component {
    constructor(props) {
        super(props)
        this.state = { score: 0, 
                       gameOver: false, 
                       cards: this.generateBoard(),  
                    }
    };

    // creates an array of cards, in a random order
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

    // creates a card and 
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

    // renders score, restart, and the board of tiles
    render() { 
        let score = <div className="column">
            Score: {this.state.score}
        </div>
        let restart = <div className="column">
            <button class="button button-outline">Restart</button>
        </div>

        let board = _.map(this.state.cards, (card) => {
            return <Card data={card} buttoncall={this.click.bind(this)}/>;
        });
        
    return <div className="column-pairs">
       {board}
       <button class="button button-outline" onClick={this.reset.bind(this)}>Reset</button>
       Score: {this.state.score}
       </div>
    }

    // goes through the logic of the game:
    // if you're flipping one card show it, 
    // if you're flipping the second card, show it and check if it is a match 
    // changes state accordingly
    click(cardID) {
        let stateCards = this.state.cards;
        let flips = this.numFlips(stateCards);
        let updateCards = [];

        //console.log(flips);

        if (flips < 2) {
            stateCards.map(card => {
            if(card.cardID === cardID && !card.matched) {
                card.selected = true;
            }
            updateCards.push(card);
            });
            flips = flips + 1;
        }


        if (flips == 2) {
            if(this.isAMatch(stateCards)) {
                updateCards = [];
                stateCards.map(card => {
                    if(card.selected){
                        card.selected = false;
                        card.matched = true;
                    }
                    updateCards.push(card);
                })
            }
            else {
            this.flipBack(stateCards); 
            }
        }

        let updateScore = this.state.score;
        this.setState({
            score: updateScore + 1,
            cards: updateCards
        });
    }

    // resets the state upon the press of the reset button
    reset() {
        this.setState({
            score: 0,
            cards: this.generateBoard()
        });
    }

    // keeps track of how many cards have been flipped so far (i.e. 1 or 2)
    numFlips(stateCards) {
        let flipped = stateCards.filter(
            card => card.selected).length;
            console.log(stateCards.filter(
                card => card.selected));
            return flipped;
    }

    // evaluates the viability of a match
    isAMatch(stateCards) {
        let matched = stateCards.filter(
            card => card.selected);
            console.log("Match?");
        let c1 = matched[0];
        let c2 = matched[1];
         console.log(c1.value);
         console.log(c2.value);

        return c1.value == c2.value;
    }

    // hides all flipped cards which do not match one another
    flipBack(stateCards) {
        console.log("in flip");
        setTimeout(() => {
            stateCards.map(card => {
                card.selected = false;
               
            })
            this.setState({
                cards: stateCards
            })
        }
        ,1000)
    }

}

// Component which represents a card
// based on props passed in, this will return a specific button
  function Card(props) {
    let cardData = props.data;
    let value = <p>{cardData.value}</p>;
    let cardNum = cardData.cardID;

    if (cardData.matched) {
        return <button  class="button matched" onClick={() => props.buttoncall(cardNum)}>{value}</button>;
    }
    if (cardData.selected) {
        return <button onClick={() => props.buttoncall(cardNum)}>{value}</button>;
    }

    if (!cardData.selected) {
        return <button onClick={() => props.buttoncall(cardNum)}>?</button>;
    }
    return;
  }