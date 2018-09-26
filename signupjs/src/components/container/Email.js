import React, { Component } from 'react';
import EmailPresentation from '../presentation/Email';

class Email extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: '',
      marketing_consent: '',
      errors: []
    };
  }

  setStateFromEvent = (name, event) => {
    this.setState({ [name]: event.target.value });
  }

  validate = () => {
    const errors = [];

    if (this.state.email === '' || this.state.email.indexOf('@') === -1) {
      errors.push('email');
    }

    if (this.state.marketing_consent === '') {
      errors.push('marketing_consent');
    }

    this.setState({ errors });
    return errors.length == 0;
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
        marketing_consent={this.state.marketing_consent}
        onSubmit={this.onSubmit}
        errors={this.state.errors}
        setStateFromEvent={this.setStateFromEvent}
      />
    );
  }
}

export default Email;
