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
            score: 0,
            players: [],
            gameOver: false}; 
    
        this.channel.join()
                    .receive("ok", this.gotView.bind(this))
                    .receive("error", resp => { console.log("Unable to join", resp) });
            
            this.channel.on("selectCard", state => {
                this.setState({state})
            })
            this.channel.on("restart", state => {
                this.setState({state});
            })
            this.channel.on("view", state => {
                this.setState({state});
            })

    };

    gotView(view) {
        console.log("got view");
        this.setState(view.game);
      }

      flipCard(cardID) {
          if(this.state.skel[cardID].selected || this.state.skel[cardID].matched) {
            return;
          }
          else {
            this.channel.push("selectCard", { index: cardID });
          }
      }

      restart() {
          this.channel.push("restart");
      }

      render() {
          let board = null;
          console.log(this.state.players);

        // Are there more than 2 players in the game?
        if (this.state.players.length < 2) {
            // there are not, so go to lobby
            return this.enterLobby();
        }
        else if (this.state.gameOver) {
           return <p> you won </p>
        }
        else {
            // there are two players, you can now join
            // as an observer
            console.log(this.state.score)
            board = _.map(this.state.skel, (card, i) => {
                return <Card key={i} value={card} buttoncall={this.flipCard.bind(this, i)}/>;
            });
        }
        return <div className="column-pairs">
        {board}
        <button className="button button-outline" onClick={this.restart.bind(this)}>Reset</button>
        Score: {this.state.score}
        </div>
      }
      
      enterLobby() {  
        // Has a player joined already?
        let waitingView = <p>test</p>;
        if (this.state.players.length == 1) {
            console.log("Only one player")
            // As a single player, you need to wait for another
            // player to join the game
            waitingView = 
            <div className="column">
            <h2> you been lobbied </h2>
            </div>
        }
        return (
        <div className="row">
        {waitingView}
        
        <button class="button" onClick={() => this.channel.push("join_game")}>Join The Game !!</button>
        </div>
        )  
    }
    }

    function Card(props) {
        let cardData = props.value;
        let cardValue = cardData.value;
        let cardIndex = cardData.cardID    
    
        if (cardData.matched) {
            console.log("match")
            return <button  class="button matched">{cardValue}</button>;
        }
        if (cardData.selected) {
            console.log("selected")
            return <button>{cardValue}</button>;
        }
    
        if (!cardData.selected) {
            console.log("selecting")
            return <button onClick={() => props.buttoncall(cardIndex)}>?</button>;
            
        }
        return;
      }

     