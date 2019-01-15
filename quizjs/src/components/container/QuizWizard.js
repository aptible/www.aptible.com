import React, { Component } from 'react';
import Wizard from './Wizard';
import Risk from '../container/Risk';
import Trust from '../container/Trust';
import Process from '../container/Process';
import Business from '../container/Business';

class QuizWizard extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  stepCompleted = (view, newFacts) => {
    //
  }

  wizardCompleted = (facts) => {
    window.location.href = `/quiz/results/?${this.resultsUrl(facts).join('&')}`;
  }

  resultsUrl = (sections) => {
    const params = [];
    for (let name in sections) {
      if (name === 'currentStep')
        continue;

      params.push(`${name}=${sections[name].join(',')}`);
    }

    return params;
  }

  render() {
    const stepViews = [Risk, Trust, Process, Business];

    return (
      <Wizard
        stepViews={stepViews}
        stepCompleted={this.stepCompleted}
        wizardCompleted={this.wizardCompleted}
      />
    );
  }
}

export default QuizWizard;
