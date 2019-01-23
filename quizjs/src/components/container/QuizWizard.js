import React, { Component } from 'react';
import Wizard from './Wizard';
import Intro from '../container/Intro';
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
    const params = [`self=${sections.self_assessment}`];
    for (let name in sections) {
      if (name === 'currentStep' || name === 'self_assessment')
        continue;

      params.push(`${name}=${sections[name].join(',')}`);
    }

    return params;
  }

  render() {
    const stepViews = [Intro, Risk, Trust, Process, Business];

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
