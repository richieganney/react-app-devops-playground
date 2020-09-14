import React from 'react';
import axios from 'axios';
import '../App.css';

class FactGenerator extends React.Component {
    constructor() {
      super();
      this.state = {
          fact: ""
      };
      this.getFact = this.getFact.bind(this);
      this.onClick = this.onClick.bind(this);
    }

    getFact(){
        const url = `${process.env.REACT_APP_CORS_PROXY}/${process.env.REACT_APP_PANDA_FACT_URL}`
        axios.get(url)
        .then(res => {
            this.setState({fact: res.data.fact})
        })
        .catch(error => {
            console.log(error)
        })
    }

    onClick() {
        this.getFact()
    }

    render() {
        return (
            <div className="wrapper">
                <div onClick={this.onClick} className="get_fact">panda fact</div>
                <p className="display-fact">{this.state.fact}</p>
            </div>
          );
    }
}

export default FactGenerator;