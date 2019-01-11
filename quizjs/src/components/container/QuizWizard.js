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
    console.log(view.className(), newFacts);
  }

  wizardCompleted = (facts) => {
    console.log('quiz complete');
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
