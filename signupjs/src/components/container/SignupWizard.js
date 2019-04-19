import React, { Component } from 'react';
import axios from 'axios';
import Wizard from './Wizard';
import Email from '../container/Email';
import Customize from '../container/Customize';
import ProductSelection from '../container/ProductSelection';
import HowHeard from '../container/HowHeard';
import Profile from '../container/Profile';

const FORMKEEP_ID = 'f6bad6b94e88';

const AUTOPILOT_DEFAULT_FIELD_MAPPINGS = {
  email: 'Email',
  first_name: 'FirstName',
  last_name: 'LastName',
  role: 'Title',
  company_name: 'Company',
  company_url: 'Website',
  company_size: 'NumberOfEmployees'
};

const AUTOPILOT_CUSTOM_FIELD_MAPPINGS = {
  marketing_consent: 'string--Contact--Consent',
  utm_campaign: 'string--utm_campaign',
  utm_source: 'string--utm_source',
  utm_medium: 'string--utm_medium',
  signup_started: 'string--Gridiron--Signup--Started',
  signup_completed: 'string--Gridiron--Signup--Completed',
  main_goal: 'string--Main--Goal--with--Gridiron',
  protocols: 'string--Compliance--Frameworks--of--Interest',
  how_heard: 'string--Origin--of--Gridiron--Interest',
  gclid: 'string--GCLID'
};


class SignupWizard extends Component {
  constructor(props) {
    super(props);
    this.state = {
      email: ''
    };
  }

  stepCompleted = (view, newFacts) => {
    if ('email' in newFacts) {
      // Check for gclid cookie
      if (aptible.cookie.get('aptible_gclid')) {
        newFacts.gclid = aptible.cookie.get('aptible_gclid');
      }

      // Send to formkeep first so we at least have their email
      this.sendToFormKeep(newFacts);

      // First step completed, identify this visitor
      aptible.analytics.identify(newFacts.email);
      aptible.analytics.event(aptible.analytics.events.EMAIL_COLLECTED);
      aptible.analytics.fireAllPixels();

      if (aptible.analytics.getParam('gridiron')) {
        aptible.analytics.event(aptible.analytics.events.SIGNUP_GRIDIRON);
      }

      // Send to autopilot, and Salesforce from there
      this.sendToAutopilot({
        Email: newFacts.email,
        custom: this.formatAutopilotFields(
          Object.assign(newFacts, aptible.analytics.allUtmVars(), { signup_started: this.currentTime() }),
          AUTOPILOT_CUSTOM_FIELD_MAPPINGS
        )
      });

      // Keep their email address for later autopilot calls
      this.setState({ email: newFacts.email });
    } else if ('enclave' in newFacts) {
      aptible.analytics.event(aptible.analytics.events.SIGNUP_ENCLAVE);

      // Give some time for the analytics event to fire
      setTimeout(() => {
        window.location = `https://dashboard.aptible.com/signup?email=${this.state.email}`;
      }, 500);
    } else {
      if (this.state.email && Object.keys(newFacts).length > 0) {
        newFacts.email = this.state.email;

        // Format into something Autopilot understands
        const payload = this.formatAutopilotFields(newFacts, AUTOPILOT_DEFAULT_FIELD_MAPPINGS);
        payload.custom = this.formatAutopilotFields(newFacts, AUTOPILOT_CUSTOM_FIELD_MAPPINGS);

        this.sendToAutopilot(payload);
      }

      if ('gridiron' in newFacts && aptible.analytics.getParam('gridiron') === undefined) {
        aptible.analytics.event(aptible.analytics.events.SIGNUP_GRIDIRON);
      }
    }

    // Fire an event for each step in the signup wizard
    if (view.className) {
      aptible.analytics.event(`Signup Step Completed: ${view.className()}`);
    }
  }

  wizardCompleted = (facts) => {
    this.sendToFormKeep(facts);

    if (this.state.email) {
      this.sendToAutopilot({
        Email: this.state.email,
        custom: this.formatAutopilotFields(
          { signup_completed: this.currentTime() },
          AUTOPILOT_CUSTOM_FIELD_MAPPINGS
        )
      });
    }

    // Delay the redirect to give time for analytics to be sent
    setTimeout(() => {
      window.location = '/signup/thank-you/';
    }, 1500);
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
      if (Object.keys(payload.custom).length < 1) {
        delete payload.custom;
      }

      window.Autopilot.run('associate', payload);
    }
  }

  formatAutopilotFields = (data, mapping) => {
    const payload = {};

    for (let field in data) {
      if (field == 'name') {
        const namePieces = data[field].split(' ');
        payload[AUTOPILOT_DEFAULT_FIELD_MAPPINGS.first_name] = namePieces[0];

        if (namePieces.length > 1) {
          payload[AUTOPILOT_DEFAULT_FIELD_MAPPINGS.last_name] = namePieces[1];
        }
      } else if (field in mapping) {
        payload[mapping[field]] = data[field];
      }
    }

    return payload;
  }

  currentTime = () => {
    return new Date().toISOString();
  }

  render() {
    const stepViews = [Email, ProductSelection, Customize, HowHeard, Profile];

    return (
      <Wizard
        stepViews={stepViews}
        stepCompleted={this.stepCompleted}
        wizardCompleted={this.wizardCompleted}
      />
    );
  }
}

export default SignupWizard;
