import React, { Component } from 'react';
import BusinessPresentation from '../presentation/Business';
import { unAnsweredQuestions, collectAnswers } from '../lib/scoring';
import QUIZ_DATA from '../../quiz_data.json';

class Business extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  static className() {
    return 'Business';
  }

  recordAnswer = (question, answer) => {
    this.setState({ [question]: answer });
  }

  validate = () => {
    return unAnsweredQuestions(QUIZ_DATA.business, this.state).length === 0;
  }

  onSubmit = () => {
    if (this.validate()) {
      this.props.nextStep({ business: collectAnswers(QUIZ_DATA.business, this.state) });
    }
  }

  render() {
    return (
      <BusinessPresentation
        questions={QUIZ_DATA.business.questions}
        recordAnswer={this.recordAnswer}
        onSubmit={this.onSubmit}
      />
    );
  }
}

export default Business;
