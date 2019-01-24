import React, { Component } from 'react';
import IntroPresentation from '../presentation/Intro';

class Intro extends Component {
  constructor(props) {
    super(props);
    this.state = {
      self_assessment: '',
      questions: [
        {
          id: "self_assessment",
          type: "self_assessment",
          text: "Before we begin, how would you currently describe your team's security culture?"
        }
      ]
    };
  }

  static className() {
    return 'Intro';
  }

  recordAnswer = (question, answer) => {
    this.setState({ [question]: answer.toString() });
  }

  validate = () => {
    return this.state.self_assessment !== '';
  }

  onSubmit = () => {
    if (this.validate()) {
      this.props.nextStep({ self_assessment: this.state.self_assessment });
    } else {
      alert('Please answer all questions before continuing');
    }
  }

  render() {
    return (
      <IntroPresentation
        questions={this.state.questions}
        recordAnswer={this.recordAnswer}
        onSubmit={this.onSubmit}
      />
    );
  }
}

export default Intro;
