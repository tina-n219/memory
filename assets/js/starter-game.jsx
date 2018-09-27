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
    //let originalclicks = 0;
    this.state = {
      board: this.createBoard(cardvalues),
      //endGame: this.gameState(),
      //clickCount: this.clickIncrease(originalclicks)
    };
  }

  // Create the board of cards, where every card has a letter value, and whether 
  // it 
  createBoard(pairs) {
    let cardsready = _.shuffle(_.concat(pairs, pairs));
    let cards = [];
    for (let index = 0; index < 16; index++) {
      var onecard = 
      {
        flipped: false,
        paired: false,
        cardvalue: cardsready[index]
      }

      if (!onecard.flipped) {
        onecard.cardvalue = "?";
      }
      cards.push(onecard);
    }
    return cards;
  }

  // If a button is clicked, show the cardValue for 5 seconds
  // Check if another card has been flipped, and if so, are they the same
  // If they are the same, switch both to paired
  // If another card has not been flipped, leave it 
  // Add a click to the counter
  
// clickIncrease() {
//   this.clickCount =+ 1;
// }  
  
  flipCard() {
    this.state.board[0].flipped = true;
    console.log(1);
    //this.clicks += 1;
  }

  render() {

	let card1 = 
  <div className="col-3">
    <div className="button" onClick={this.flipCard.bind(this)}>
      <p>{this.state.board[0].cardvalue}</p>
    </div>
  </div>;

let card2 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[1].cardvalue}</p>
  </div>
</div>;

let card3 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[2].cardvalue}</p>
  </div>
</div>;

let card4 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[3].cardvalue}</p>
  </div>
</div>;

let card5 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[4].cardvalue}</p>
  </div>
</div>;

let card6 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[4].cardvalue}</p>
  </div>
</div>;

let card7 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[5].cardvalue}</p>
  </div>
</div>;

let card8 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[6].cardvalue}</p>
  </div>
</div>;

let card9 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[7].cardvalue}</p>
  </div>
</div>;

let card10 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[9].cardvalue}</p>
  </div>
</div>;

let card11 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[10].cardvalue}</p>
  </div>
</div>;


let card12 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[11].cardvalue}</p>
  </div>
</div>;


let card13 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[12].cardvalue}</p>
  </div>
</div>;

let card14 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[13].cardvalue}</p>
  </div>
</div>;

let card15 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[14].cardvalue}</p>
  </div>
</div>;

let card16 = 
<div className="col-3">
  <div className="button">
    <p>{this.state.board[15].cardvalue}</p>
  </div>
</div>;

  return <div className="row">
    {card1}
    {card2}
    {card3}
    {card4}
    {card5}
    {card6}
    {card7}
    {card8}
    {card9}
    {card10}
    {card11}
    {card12}
    {card13}
    {card14}
    {card15}
    {card16}
 
     </div>;

}


}