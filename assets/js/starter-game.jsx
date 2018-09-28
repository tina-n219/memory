import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
  ReactDOM.render(<Starter />, root);
}


class Starter extends React.Component {
  
  constructor(props) {
    super(props);
    let cardvalues = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
    this.startOver = this.startOver.bind(this)

    //let clicks = 0;
    this.state = {
      board: this.createBoard(cardvalues),
      clickCount: 0,
      firstCardClickedIndex: -1,
      gameWon: false
    };
  }

  startOver() {
    this.setState = ({
      board: this.createBoard(this.cardvalues),
      clickCount: 0,
      firstCardClickedIndex: -1,
      gameWon: false
    });
  }

  // Create the board of cards, where every card has a letter value, and whether 
  // it 
  createBoard(pairs) {
    let cardsready = _.shuffle(_.concat(pairs, pairs));
    let cards = [];
    for (let index = 0; index < 16; index++) {
      console.log(index);
      var onecard = 
      {
        flipped: false,
        paired: false,
        cardvalue: cardsready[index]
      }
      cards.push(onecard);
    }
    return cards;
  }

  disableClick() {
    let flippedCards = this.state.board.filter(onecard => {
       onecard.flipped;
    });
    console.log(flippedCards.length);
    return false;
  }


  flipCard(index) {

    if (this.disableClick()) {
      return;
    }
    
    // Increase click count
    let clickCount = this.state.clickCount;
    clickCount = clickCount + 1;

    // Flip the card
    let cardClicked = this.state.board[index];
    cardClicked.flipped = true;

    // Update the board
    this.state.clickCount = clickCount;
    let newBoard =this.state.board;
    let state1 = _.assign( {}, this.state, newBoard);
    this.setState(state1);


    let checkFlipped = () => {

      if (this.state.firstCardClickedIndex > 0 && clickCount % 2 == 0) {
        
        let firstCardClicked = this.state.board[this.state.firstCardClickedIndex];

         // Are their values equal?
        if (firstCardClicked.cardvalue == cardClicked.cardvalue && !(cardClicked.key == firstCardClicked.cardvalue)) {
          firstCardClicked.paired = true; 
          cardClicked.paired = true;
        }

        // If values are not equal
        else {
          firstCardClicked.paired = false;
          cardClicked.paired = false;
          firstCardClicked.flipped = false;
          cardClicked.flipped = false;
        }
   
        // UPDATE THE BOARD
        this.state.board[this.state.lastCardClicked] = firstCardClicked;
        this.state.board[index] = cardClicked;
        this.state.lastCardClicked = -1;
   
        // Update the board
        let newBoard2 =this.state.board;
        let state2 = _.assign( {}, this.state, newBoard2);
        this.setState(state2);
      }
      else {
        this.state.firstCardClickedIndex = index;
      }
    }
    setTimeout(() => { checkFlipped(); }, 1000);
  }


  render() {
    if (this.state.gameWon) {
      return;
    }
else {


  return (
    <div className="row">
      {_.map(this.state.board, (tile, i) => <Tile key={i} cardvalue={tile.cardvalue} hidden={tile.flipped || tile.paired} onClick={this.flipCard.bind(this, i)}/>)}
      <div className="button" id="restartButton" onClick={this.startOver.bind(this)}>
       <p> Restart </p>
      </div>

      <div  className="row">
        <div className="clicksCount">
         <h1> Clicks: {this.state.clickCount}</h1>
        </div>
      </div>
   </div>
  );
  }
}
}

function Tile(props) {
  return (
    <div className="col-3">
      <div className="button" onClick={props.onClick}>
       <p> {props.hidden ? props.cardvalue : "?"} </p>
      </div>
    </div>
  );
  
}