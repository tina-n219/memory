import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root, channel) {
    ReactDOM.render(<Board channel={channel} />, root);
}

class Board extends React.Component {
    constructor(props) {
        super(props)

        this.channel = props.channel;
        this.state = {
            skel: [],
            clickCount: 0,
            players: [],
            gameOver: false
        };
        this.channel.join()
            .receive("ok", this.gotView.bind(this))
            .receive("error", resp => { console.log("Unable to join", resp) });

        this.channel.on("update", state => {
            this.setState(state);
        })

    };

    gotView(view) {
        console.log("got view");
        this.setState(view.game);
    }

    flipCard(cardID) {
        if (this.state.skel[cardID].selected || this.state.skel[cardID].matched) {
            return;
        }
        else {
            this.channel.push("selectCard", { index: cardID })
        // Not sure about this 
        // .receive("ok", this.gotView.bind(this));
        }
    }

    restart() {
        this.channel.push("restart");
    }

    render() {
        // Are there more than 2 players in the game?
        console.log(this.state.players.length);
        let gameBoard = null;
        if (this.gameOver()) {
            return <h1>you just coded for 15 + hrs to get this to appear</h1>
        }
        else if (this.state.players.length < 2) {
            // there are not, so go to lobby
            return this.enterLobby();
        }
        else {
            // there are two players, you can now join
            // as an observer
            // return this.enterGame();
            console.log("does it make it")
            gameBoard = _.map(this.state.skel, (card, i) => {
                return <Card key={i} value={card} buttoncall={this.flipCard.bind(this, i)} />;
            });
        return (<div className="column-pairs">
        {gameBoard}
        <button className="button button-outline" onClick={this.restart.bind(this)}>Reset</button>
        Click count: {this.state.clickCount}
        </div>);        }
    }

    // enterGame() {
    //     let gameBoard = _.map(this.state.skel, (card, i) => {
    //         <Card key={i} value={card} buttoncall={this.flipCard.bind(this, i)} />;
    //     });
    //     return <div className="column-pairs">
    //         {gameBoard}
    //         <button className="button button-outline" onClick={this.restart.bind(this)}>Reset</button>
    //         clickCount: {this.state.clickCount}
    //     </div>
    // }

    enterLobby() {
       
        return (
            <div className="column">
                <h2> you been lobbied</h2> 
                <p>waiting for another player</p>
                <button class="button" onClick={() => this.channel.push("join_game")}>Join The Game !!</button>
            </div>
        )
    }

    gameOver() {
        let matchedCards = _.filter(this.state.skel, 'matched');
        if( matchedCards.length == this.state.skel.length) {
            this.state.gameOver = true;
        }

        return matchedCards.length == this.state.skel.length && this.state.gameOver;
    }
}

function Card(props) {
    let cardData = props.value;
    let cardValue = cardData.value;
    let cardIndex = cardData.cardID
    if (cardData.matched) {
        console.log("match")
        return <button class="button matched">{cardValue}</button>;
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
