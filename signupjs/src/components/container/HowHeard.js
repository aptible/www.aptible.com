import React, { Component } from 'react';
import HowHeardPresentation from '../presentation/HowHeard';

class HowHeard extends Component {
  constructor(props) {
    super(props);
    this.state = {
      how_heard: ''
    };
  }

  setStateFromEvent = (name, event) => {
    this.setState({ [name]: event.target.value });
  }

  onSubmit = () => {
    this.props.nextStep(this.state);
  }

  onSkip = () => {
    this.props.nextStep({});
  }

  render() {
    return (
      <HowHeardPresentation
        how_heard={this.state.how_heard}
        onSubmit={this.onSubmit}
        onSkip={this.onSkip}
        setStateFromEvent={this.setStateFromEvent}
      />
    );
  }
}

export default HowHeard;
