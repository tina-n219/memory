import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
    ReactDOM.render(<Board />, root);
  }

  class Card extends React.Component {
      constructor(props) {
          super(props)
          this.state = {};
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
        <p>Game Over: {this.state.gameOver}</p>
      </div>;

        return <div className="row">
        {score}
      </div>
        ;
    }
  }