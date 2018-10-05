import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root, channel) {
    ReactDOM.render(<Board channel={channel}/>, root);
  }

  class Board extends React.Component {
    constructor(props) {
        super(props)

        this.channel = props.channel;
        this.state = { skel: [], score: 0}; 

        this.channel.join()
                    .receive("ok", this.gotView.bind(this))
                    .receive("error", resp => { console.log("Unable to join", resp) });
        
    };

    gotView(view) {
        console.log("new view", view);
        this.setState(view.game);
      }

      sendGuess(i) {
        this.channel.push("guess", { cardIndex: i })
            .receive("ok", this.gotView.bind(this));
      }

      restart() {
          this.channel.push("restart", )
      }

      render() {
        let board = _.map(this.state.skel, (card) => {
            return <Card value={card} buttoncall={this.sendGuess.bind(this)}/>;
        });

        return <div className="column-pairs">
        {board}
        <button className="button button-outline">Reset</button>
        Score: {this.state.score}
        </div>
      }
    }

    function Card(props) {
        let cardData = props.value;
        // let value = <p>{cardData.value}</p>;
        // let cardNum = cardData.cardID;
        
        if (cardData.matched) {
            console.log("match")
            return <button  class="button matched">{cardData.cardIndex}</button>;
        }
        if (cardData.selected) {
            console.log("selected")
            return <button>{cardData.cardIndex}</button>;
        }
    
        if (!cardData.selected) {
            console.log("selecting")
            return <button onClick={() => props.buttoncall(cardData.cardIndex)}>?</button>;
        }
        return;
      }

     