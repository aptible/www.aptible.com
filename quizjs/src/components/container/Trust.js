import React, { Component } from 'react';
import TrustPresentation from '../presentation/Trust';
import { unAnsweredQuestions, scoreSection } from '../lib/scoring';
import QUIZ_DATA from '../../quiz_data.json';

class Trust extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  static className() {
    return 'Trust';
  }

  recordAnswer = (question, answer) => {
    this.setState({ [question]: answer });
  }

  validate = () => {
    return unAnsweredQuestions(QUIZ_DATA.trust, this.state).length === 0;
  }

  onSubmit = () => {
    if (this.validate()) {
      this.props.nextStep(scoreSection('trust', QUIZ_DATA.trust, this.state));
    }
  }

  render() {
    return (
      <TrustPresentation
        questions={QUIZ_DATA.trust.questions}
        recordAnswer={this.recordAnswer}
        onSubmit={this.onSubmit}
      />
    );
  }
}

export default Trust;
