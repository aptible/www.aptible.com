import React from 'react';
import { errorClass } from '../../lib/errors';

const Customize = ({ main_goal, protocols, onSubmit, errors, setStateFromEvent }) => (
  <div className="signup__step">
    <h2>Customize Gridiron</h2>
    <p className="text-center">
      We tailor Gridiron based on what matters most to you, ensuring that we
      provide you only with what's most relevant to your needs.
    </p>

    <label htmlFor="signup-main-goal">What is your main goal today?</label>
    <div className="signup__select-container">
      <select
        value={main_goal}
        onChange={(e) => setStateFromEvent('main_goal', e)}
        id="signup-main-goal"
        className={errorClass(errors, 'main_goal')}
      >
        <option>Select...</option>
        <option value="Create sales collateral / streamline vendor security questionnaires">Create sales collateral / streamline vendor security questionnaires</option>
        <option value="Expand into regulated industries (ex: healthcare)">Expand into regulated industries (ex: healthcare)</option>
        <option value="Ensure your business is securing data appropriately">Ensure your business is securing data appropriately</option>
        <option value="Other">Other</option>
      </select>
    </div>

    <label htmlFor="signup-protocols">What compliance framework are you working with?</label>
    <div className="signup__select-container">
      <select
        value={protocols}
        onChange={(e) => setStateFromEvent('protocols', e)}
        id="signup-protocols"
        className={errorClass(errors, 'protocols')}
      >
        <option>Select...</option>
        <option value="GDPR">GDPR</option>
        <option value="HIPAA">HIPAA</option>
        <option value="ISO 27001">ISO 27001</option>
        <option value="NIST CSF">NIST CSF</option>
        <option value="SOC 2">SOC 2</option>
        <option value="I don't know">I don't know</option>
        <option value="Other">Other</option>
      </select>
    </div>

    <button onClick={onSubmit}>Next <i className="far fa-long-arrow-right"></i></button>
  </div>
);

export default Customize;
