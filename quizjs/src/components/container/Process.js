import React, { Component } from 'react';
import ProcessPresentation from '../presentation/Process';
import { unAnsweredQuestions, collectAnswers } from '../lib/scoring';
import QUIZ_DATA from '../../quiz_data.json';

class Process extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  static className() {
    return 'Process';
  }

  recordAnswer = (question, answer) => {
    this.setState({ [question]: answer });
  }

  validate = () => {
    return unAnsweredQuestions(QUIZ_DATA.process, this.state).length === 0;
  }

  onSubmit = () => {
    if (this.validate()) {
      this.props.nextStep({ process: collectAnswers(QUIZ_DATA.process, this.state) });
    } else {
      alert('Please answer all questions before continuing');
    }
  }

  render() {
    return (
      <ProcessPresentation
        questions={QUIZ_DATA.process.questions}
        recordAnswer={this.recordAnswer}
        onSubmit={this.onSubmit}
      />
    );
  }
}

export default Process;
