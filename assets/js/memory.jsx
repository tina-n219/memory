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
        this.channel.push("guess", { letter: ev.key })
            .receive("ok", this.gotView.bind(this));
      }
    }

    function Score(props) {
        let score = props.score;
        return <p>Score: { score }</p>;
    }  

     