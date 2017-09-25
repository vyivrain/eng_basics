import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'
import FlashMessages from './flash_messages'
import './fibs.scss';

export default class FibNumberExistForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { numberValue: '' };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleSubmit(event) {
    event.preventDefault();
    axios.post(`/api/v1/fibs/${this.props.fibId}/check_item_exist`, { fib: { number: this.state.numberValue } })
    .then(function(response) {
      ReactDOM.render(
        <FlashMessages message={response['data']['message']} status={response['data']['status']} />,
        document.getElementById('flash-messages')
      )
    });
  }

  handleChange(event) {
    this.setState({ numberValue: event.target.value })
  }

  render() {
    return(
      <form onSubmit={this.handleSubmit}>
        <div className="col-lg-10">
          <input type="number" value={this.state.numberValue} data-eq-input onChange={this.handleChange} className="form-control" name="fib[number]" />
        </div>
        <div className="col-lg-2">
          <input type="submit" className="btn btn-success btn-sm check-button" value="Check" data-submit />
        </div>
      </form>
    )
  }
}
