import React, { Component } from 'react';
import ReactCSSTransitionReplace from 'react-css-transition-replace';

class Wizard extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentStep: 0
    };
  }

  nextStep = (factsFromStep) => {
    this.collectNewFactsFromStep(factsFromStep, (newFactsFromStep) => {
      this.props.stepCompleted(this.currentView(), newFactsFromStep);

      if (this.stepsLeft()) {
        this.setState({ currentStep: this.state.currentStep + 1 });
      } else {
        this.completed();
      }
    });
  }

  previousStep = () => {
    if (this.currentStep > 0) {
      this.setState({ currentStep: this.state.currentStep - 1 });
    }
  }

  completed = () => {
    this.props.wizardCompleted(this.state);
  }

  stepsLeft = () => {
    return this.state.currentStep < this.props.stepViews.length - 1;
  }

  onLastStep = () => {
    return this.state.currentStep === this.props.stepViews.length - 1;
  }

  collectNewFactsFromStep = (facts, callback) => {
    const newFacts = {};

    for (const fact in facts) {
      if (fact === 'errors')
        continue;

      const value = facts[fact];
      if (fact && value && value.length > 0 && this.state[fact] !== value) {
        newFacts[fact] = value;
      }
    }

    this.setState(newFacts, () => { callback(newFacts); });
  }

  currentView = () => {
    return this.props.stepViews[this.state.currentStep];
  }

  render() {
    const CurrentView = this.currentView();

    return (
      <ReactCSSTransitionReplace transitionName="fade-wait"
        transitionEnterTimeout={1000} transitionLeaveTimeout={1000}>
        <CurrentView
          key={this.state.currentStep}
          nextStep={this.nextStep}
          previousStep={this.previousStep}
        />
      </ReactCSSTransitionReplace>
    );
  }
}

export default Wizard;
