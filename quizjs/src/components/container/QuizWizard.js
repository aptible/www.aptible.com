import React, { Component } from 'react';
import Wizard from './Wizard';
import Risk from '../container/Risk';

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
    const stepViews = [Risk];

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
