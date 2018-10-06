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
        this.state = { 
            skel: [], 
            score: 0}; 

        
        // {"ok", view}
        // {:ok, %{"game" => State.client_view(game)}}
        this.channel.join()
                    .receive("ok", this.gotView.bind(this))
                    .receive("error", resp => { console.log("Unable to join", resp) });
        
    };

    gotView(view) {
        // console.log("new view", view);

       /* game = %{
            skel: game.board, 
            score: 0
        } */

        console.log(view.game)
        this.setState(view.game);
      }

      guess(cardID) {
        this.channel.push("selectCard", { index: cardID })
            .receive("ok", this.gotView.bind(this));
      }

      restart() {
          this.channel.push("restart")
          .receive("ok", this.gotView.bind);
      }

      render() {
        let board = _.map(this.state.skel, (card) => {
            return <Card value={card} buttoncall={this.guess.bind(this)}/>;
        });

        //console.log(this.state.skel)
        return <div className="column-pairs">
        {board}
        <button className="button button-outline" onClick={this.restart.bind(this)}>Reset</button>
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
            return <button  class="button matched">{cardData.value}</button>;
        }
        if (cardData.selected) {
            console.log("selected")
            return <button>{cardData.value}</button>;
        }
    
        if (!cardData.selected) {
            console.log("selecting")
            return <button onClick={() => props.buttoncall(cardData.cardID)}>?</button>;
            
        }
        return;
      }

     