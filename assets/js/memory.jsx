import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root) {
    ReactDOM.render(<Board />, root);
  }

  class Board extends React.Component {
    constructor(props) {
        super(props)
        let values = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
        this.state = { score: 0, 
                       gameOver: false, 
                       pairs: _.shuffle(_.concat(values, values)),
                    }
    };

    render() {
        let score = <div className="column">Score: {this.state.score}</div>
        return <div className="column-pairs">
       <GenerateBoard pairs={this.state.pairs}/>
       {score}
       </div>
    }
}

  function GenerateBoard(props) {
      const column = [];
    for(let i = 0; i < 4; i++) {
        const row = [];
        for (let j = 0; j < 4; j++) {
            var grabNum = 4*i + j;
        row.push(
            <Card value={props.pairs[grabNum]} selected= {true} matched= {false} />);
            }
        column.push(
            <div className= "row-board">
            {row}
            </div>
        );
    }
    return <div className="column-board">{column}</div>
  }

  function Card(props) {
    let value = <div className="column"> 
    <p>{props.value}</p>
    </div>

    if (props.matched) {
        return <button>{value}</button>;
    }
    if (props.selected) {
        return <button>{value}</button>;
    }

    if (!props.selected) {
        return <button class="button button-outline">?</button>;
    }
    return;


  }