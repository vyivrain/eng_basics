import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'
import FlashMessages from './flash_messages'
import './fibs.scss';


export default class FibCreate extends React.Component {
  constructor(props) {
    super(props);
    this.state = { fibonacciNumber: '' };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();
    axios.post(`/api/v1/fibs`, { fib: { number: this.state.fibonacciNumber } })
      .then(function(response) {
        window.location.href = '/?creating="now"'
      });
  }

  handleChange(event) {
    this.setState({ fibonacciNumber: event.target.value })
  }

  render() {
    return(
      <form onSubmit={this.handleSubmit}>
        <div className="form-group">
          <label name="fib[number]">Generate N fibonacci numbers</label>
          <input type="number" className="form-control" onChange={this.handleChange} />
        </div>
        <div className="actions">
          <input type="submit" className="btn btn-success" value="Generate" />
        </div>
      </form>
    )
  }
}

document.addEventListener("turbolinks:load", e => {
  if(document.getElementById('fib-create-form'))
    ReactDOM.render(<FibCreate />, document.getElementById('fib-create-form'))
});
