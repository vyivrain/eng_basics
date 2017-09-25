import React from 'react'
import ReactDOM from 'react-dom'
import './fibs.scss'

export default class FlashMessages extends React.Component {
  constructor(props) {
    super(props);
    this.unmountElement = this.unmountElement.bind(this);
  }

  unmountElement() {
    ReactDOM.unmountComponentAtNode(document.getElementById('flash-messages'));
  }

  render() {
    let messages = this.props.message;
    if(typeof messages === 'string')
      messages = [messages];

    let messages_html = messages.map((obj, i) => {
      let key = `message_${i}`;
      let alertClasses = `alert alert-${this.props.status} alert-dismissable`;
      return (
        <div className={alertClasses} role="alert" key={key}>
          {obj}
          <a className="close" data-dismiss="alert" href="#" onClick={this.unmountElement}>×</a>
        </div>
      )
    });

    return(
      <div>
        {messages_html}
      </div>
    )
  }
}