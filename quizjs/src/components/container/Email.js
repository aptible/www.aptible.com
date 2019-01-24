import React, { Component } from 'react';
import EmailPresentation from '../presentation/Email';

class Email extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: '',
      marketing_consent: '',
      invalidEmail: false
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
      this.setState({ invalidEmail: true });
      return false;
    }

    if (this.state.marketing_consent === '') {
      return false;
    }

    this.setState({ invalidEmail: false });
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
        invalidEmail={this.state.invalidEmail}
        setStateFromEvent={this.setStateFromEvent}
        onSubmit={this.onSubmit}
      />
    );
  }
}

export default Email;
