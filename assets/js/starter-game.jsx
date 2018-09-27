import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
  ReactDOM.render(<Starter />, root);
}

class Starter extends React.Component {
  
  constructor(props) {
    super(props);
    var cardvalues = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
   // var cards = [];

  var um = "3";
    this.state = { left: false };
  }

  createBoard() {
    cardvalues._concat();
    cardvalues._shuffle();
    for (let index = 0; index < 16; index++) {
      cards.push(newCard(cardvalues[i]));
    }
  }

  newCard(props) {
    var Card =
      value = props.value;
      flipped = false;
      paired = false;
  }

  swap(_ev) {
    let state1 = _.assign({}, this.state, { left: !this.state.left });
    this.setState(state1);
  }

  hax(_ev) {
    alert("hax!");
  }

  render() {

	let card1 = 
  <div className="col-3">
    <div className="button">
      <p>1</p>
    </div>
  </div>;

let card2 = 
<div className="col-3">
  <div className="button">
    <p>?</p>
  </div>
</div>;

let card3 = 
<div className="col-3">
  <div className="button">
    <p>?</p>
  </div>
</div>;

let card4 = 
<div className="col-3">
  <div className="button">
    <p>?</p>
  </div>
</div>;

let card5 = 
<div className="col-3">
  <div className="button">
    <p>?</p>
  </div>
</div>;

let card6 = 
<div className="col-3">
  <div className="button">
    <p>?</p>
  </div>
</div>;

let card7 = 
<div className="col-3">
  <div className="button">
    <p>?</p>
  </div>
</div>;

let card8 = 
<div className="col-3">
  <div className="button">
    <p>?</p>
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
     </div>;

}


}