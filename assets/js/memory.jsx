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
       return <GenerateBoard pairs={this.state.pairs} />
    }
}

  function GenerateBoard(props) {
      const column = [];
    for(let i = 0; i < 4; i++) {
        const row = [];
        for (let j = 0; j < 4; j++) {

            row.push(
            <Card value={props.pairs[j]} selected= {true} matched= {false} />);
        }
        column.push(
            <div className= "row">
            {row}
            </div>
        );
    }
    return <div className="column">{column}</div>
  }

  function Card(props) {
    let value = <div className="coulum"> 
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