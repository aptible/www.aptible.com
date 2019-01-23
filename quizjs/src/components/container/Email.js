import React, { Component } from 'react';
import EmailPresentation from '../presentation/Email';

class Email extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: '',
      marketing_consent: ''
    };
  }

  static className() {
    return 'Email';
  }

  setStateFromEvent = (name, event) => {
    this.setState({ [name]: event.target.value });
  }

  validate = () => {
    if (this.state.email.length < 5 || this.state.email.indexOf('@') === -1) {
      return false;
    }

    if (this.state.marketing_consent === '') {
      return false;
    }

    return true;
  }

  onSubmit = () => {
    if (this.validate()) {
      this.props.nextStep(this.state);
    }
  }

  render() {
    return (
      <EmailPresentation
        email={this.state.email}
        setStateFromEvent={this.setStateFromEvent}
        onSubmit={this.onSubmit}
      />
    );
  }
}

export default Email;
