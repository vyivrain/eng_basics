import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'
import FibNumberExistForm from './fib_number_exist_form'
import FibListEqualityForm from './fib_list_equality_form'
import './fibs.scss'

export default class FibShow extends React.Component {
  constructor(props) {
    super(props);
    this.state = { fib: null };
  }

  componentWillMount() {
    let self = this;
    axios.get(`/api/v1/fibs/${this.props.fibId}`).then(response => {
      self.setState({ fib: response['data'] })
    })
  }

  render() {
    let fib = null;
    if(this.state.fib)
      fib = <tr>
              <td className="show-fibs-list" data-item>{this.state.fib['items_str']}</td>
              <td>{this.props.numberExistForm}</td>
              <td>{this.props.listEqualityForm}</td>
              <td data-fib-square>{this.state.fib['known_fib_square']}</td>
            </tr>;
    else
      fib = <tr><td data-item>Loading...</td><td>Loading...</td><td>Loading...</td><td data-fib-square>Loading...</td></tr>;

    return (
      <table className="table table-bordered text-center">
        <thead>
        <tr>
          <th className="text-center">Item List</th>
          <th className="text-center">Element exists in item list</th>
          <th className="text-center">Item List equality to another list</th>
          <th className="text-center">Fib sum square</th>
        </tr>
        </thead>
        <tbody>
          {fib}
        </tbody>
      </table>
    );
  }
}

document.addEventListener("turbolinks:load", e => {
  if(document.getElementById('fib-show-table')) {
    let fibId = window.location.href.split('/').pop();
    ReactDOM.render(
      <FibShow numberExistForm={<FibNumberExistForm fibId={fibId} />}
               listEqualityForm={<FibListEqualityForm fibId={fibId} />}
               fibId={fibId} />,
      document.getElementById('fib-show-table')
    );
  }
});
