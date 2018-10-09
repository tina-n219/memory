import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';


export default function game_init(root, channel) {
  ReactDOM.render(<Starter channel={channel} />, root);
}

class Starter extends React.Component {
  
  constructor(props) {
    super(props);

    this.channel = props.channel;
    this.state = { skel: [], score: 0}
    this.channel.join()
        .receive("ok", this.gotView.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp) });
  }

    // gotView + sendGuess, credit to Nat Tuck
    // https://github.com/NatTuck/hangman/blob/server-state/assets/js/hangman.jsx
  gotView(view) {
    console.log("new view", view)
    this.setState(view.game);
  }

  sendGuess(index) {
    this.channel.push("guess", { index: index})
        .receive("ok", this.gotView.bind(this));
  }

  flipCard(index) {
    // If they click on already flipped / paired cards, don't allow them to click
    if (this.state.skel[index].flipped || this.state.skel[index].paired) {
      return;
    }
    else {
      this.sendGuess(index);
    }
  }


  render() {
  let board = _.map(this.state.skel, (card, i) => {
    return <Tile key={i} value={card} hidden={card.flipped || card.paired}  onClick={this.flipCard.bind(this, i)}/> ;
});

    return (
    <div className="row">
    {board}
      <div className="button" id="restartButton">
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

function Tile(props) {
  let cardData = props.value;
  let cardValue = cardData.value;
  return (
    <div className="col-3">
      <div className="button" onClick={props.onClick}>
      <p>
      {props.hidden ? cardValue : "?"}
      </p>
      </div>
    </div>
  );
  
}