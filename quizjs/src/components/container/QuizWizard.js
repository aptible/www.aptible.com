import React, { Component } from 'react';
import axios from 'axios';
import Wizard from './Wizard';
import Intro from '../container/Intro';
import Risk from '../container/Risk';
import Trust from '../container/Trust';
import Process from '../container/Process';
import Business from '../container/Business';
import Email from '../container/Email';
import QUIZ_DATA from '../../quiz_data.json';

const FORMKEEP_ID = 'f6bad6b94e88';

const AUTOPILOT_CUSTOM_FIELD_MAPPINGS = {
  marketing_consent: 'string--Contact--Consent',
  utm_campaign: 'string--utm_campaign',
  utm_source: 'string--utm_source',
  utm_medium: 'string--utm_medium',
  quiz_completed: 'string--SCA--Quiz--Completed',
  quiz_results: 'string--SCA--Quiz--Results'
};

class QuizWizard extends Component {
  constructor(props) {
    super(props);
    this.state = {};

    aptible.analytics.event('Quiz Viewed');
  }

  stepCompleted = (view, newFacts) => {
    if ('self_assessment' in newFacts) {
      aptible.analytics.event('Quiz Data', {self_assessment: newFacts.self_assessment});
    }

    aptible.analytics.event(`Quiz Step Completed: ${view.className()}`);
  }

  wizardCompleted = (facts) => {
    if ('email' in facts && 'marketing_consent' in facts) {
      aptible.analytics.identify(facts.email);
      aptible.analytics.event(aptible.analytics.events.EMAIL_COLLECTED);
      aptible.analytics.event('Quiz Completed');

      const resultsUrl = `/quiz/results/?${this.resultsUrl(facts).join('&')}`;
      const analyticsPayload = {
        email: facts.email,
        marketing_consent: facts.marketing_consent,
        quiz_completed: new Date().toISOString(),
        quiz_results: `https://www.aptible.com${resultsUrl}`
      };

      this.sendToFormKeep(analyticsPayload);

      this.sendToAutopilot({
        Email: facts.email,
        custom: this.formatAutopilotFields(
          Object.assign(analyticsPayload, aptible.analytics.allUtmVars()),
          AUTOPILOT_CUSTOM_FIELD_MAPPINGS
        )
      });

      setTimeout(() => {
        window.location.href = resultsUrl;
      }, 500);
    }
  }

  resultsUrl = (sections) => {
    const params = [`self=${sections.self_assessment}`];
    for (let name in sections) {
      if (QUIZ_DATA[name] === undefined) {
        continue;
      }

      params.push(`${name}=${sections[name].join(',')}`);
    }

    return params;
  }

  sendToFormKeep = (payload) => {
    axios({
      method: 'POST',
      url: `https://formkeep.com/f/${FORMKEEP_ID}`,
      headers: { 'Accept': 'application/javascript' },
      data: payload
    });
  }

  sendToAutopilot = (payload) => {
    if (window.Autopilot) {
      window.Autopilot.run('associate', payload);
    }
  }

  formatAutopilotFields = (data, mapping) => {
    const payload = {};

    for (let field in data) {
      if (field in mapping) {
        payload[mapping[field]] = data[field];
      }
    }

    return payload;
  }

  render() {
    const stepViews = [Intro, Risk, Trust, Process, Business, Email];

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
