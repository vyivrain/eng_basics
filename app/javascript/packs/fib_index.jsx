import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios'
import './fibs.scss';

export default class FibIndex extends React.Component {
  constructor(props) {
    super(props);
    this.state = { fibs: [] };
  }

  componentWillMount() {
    let self = this;
    axios.get('/api/v1/fibs').then(response => {
      self.setState({ fibs: response['data'] })
    })
  }

  render() {
    let fibs = this.state.fibs.map(obj => {
      let fibPath = `/fibs/${obj['id']}`;
      return(
        <tr key={obj['id']}>
          <td data-items>{obj['items_str']}</td>
          <td data-created-format>{obj['created_at_format']}</td>
          <td data-actions>
            <a href={fibPath} className="btn btn-info btn-margin" data-turbolinks="false">Show</a>
            <a href={fibPath} className="btn btn-danger" data-confirm="Are you sure?" data-method="delete">Delete</a>
          </td>
        </tr>
      )
    });
    if(fibs.length === 0)
      fibs = <tr><td data-items>Loading...</td><td data-created-format>Loading...</td><td>Loading...</td></tr>;

    return (
      <table className="table table-bordered text-center">
        <thead>
          <tr>
            <th className="text-center">Items</th>
            <th className="text-center">Created</th>
            <th className="text-center">Actions</th>
          </tr>
        </thead>
        <tbody>
          {fibs}
        </tbody>
      </table>
    );
  }
}

document.addEventListener("turbolinks:load", e => {
  if(document.getElementById('fib-table'))
    ReactDOM.render(<FibIndex />, document.getElementById('fib-table'))
});
