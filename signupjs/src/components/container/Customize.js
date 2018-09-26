import React, { Component } from 'react';
import CustomizePresentation from '../presentation/Customize';

class Customize extends Component {
  constructor(props) {
    super(props);
    this.state = {
      main_goal: '',
      protocols: '',
      errors: []
    };
  }

  setStateFromEvent = (name, event) => {
    this.setState({ [name]: event.target.value });
  }

  validate = () => {
    const errors = [];

    if (this.state.main_goal === '') {
      errors.push('main_goal');
    }

    if (this.state.protocols === '') {
      errors.push('protocols');
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
      <CustomizePresentation
        main_goal={this.state.main_goal}
        protocols={this.state.protocols}
        onSubmit={this.onSubmit}
        errors={this.state.errors}
        setStateFromEvent={this.setStateFromEvent}
      />
    );
  }
}

export default Customize;
