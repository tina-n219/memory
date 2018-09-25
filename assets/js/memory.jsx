import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
    ReactDOM.render(<Board />, root);
  }

  class Card extends React.Component {
    render() {
        let value = <div className="coulum"> 
        <p>{this.props.value}</p>
        </div>

        if (this.props.matched) {
            return;
        }
        if (this.props.selected) {
            return <button>{value}</button>;
        }

        if (!this.props.selected) {
            return <button class="button button-outline">?</button>;
        }
    }
  }

  class Board extends React.Component {
    constructor(props) {
        super(props)
        this.state = { score: 0, 
                       gameOver: false };
    }

    render() {
        let score = <div className="column">
        <p>Score: {this.state.score}</p>
        <p>Game Over: {this.state.gameOver.toString()}</p>
      </div>;
        
        return <div className="row">
        <Card value="A" matched={false} selected={false}/>
        {score}
        </div>;
    }
  }