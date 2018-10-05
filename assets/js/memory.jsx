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
        this.state = { skel: [], score: 0}; // cards: this.generateBoard() };

        this.channel.join()
                    .receive("ok", this.gotView.bind(this))
                    .receive("error", resp => { console.log("Unable to join", resp) });
        
    };

    gotView(view) {
        console.log("new view", view);
        this.setState(view.game);
      }

      sendGuess(event) {
        this.channel.push("guess", { letter: event.key })
            .receive("ok", this.gotView.bind(this));
      }

      restart() {
          this.channel.push("restart", )
      }

      render() {
        let board = _.map(this.state.skel, (card) => {
            return <Card value={card}/>;
        });

        return <div className="column-pairs">
        {board}
        <button className="button button-outline">Reset</button>
        Score: {this.state.score}
        </div>
      }
    }

    function Card(props) {
        // let cardData = props.data;
        // let value = <p>{cardData.value}</p>;
        // let cardNum = cardData.cardID;
    
        if (props.matched) {
            return <button  class="button matched">{value}</button>;
        }
        if (props.selected) {
            return <button>{props}</button>;
        }
    
        if (!props.selected) {
            return <button>?</button>;
        }
        return;
      }

     