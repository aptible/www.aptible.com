import React from 'react';
import { errorClass } from '../../lib/errors';

const Email = ({ email, onSubmit, errors, setStateFromEvent }) => (
  <div className="signup__step">
    <h2>Set up your Gridiron account</h2>
    <p className="text-center">
      We'll ask a few simple questions about your company so we can tailor the
      Gridiron experience to your company's needs.
    </p>
    <p className="text-center">
      Afterwards, we'll follow up with details and next steps.
    </p>

    <label htmlFor="signup-email">Your work email</label>
    <input
      type="email"
      id="signup-email"
      placeholder="you@workdomain.com"
      value={email}
      onChange={(e) => setStateFromEvent('email', e)}
      className={errorClass(errors, 'email')}
    />

    <div className="signup__radio-group">
      <div className={errorClass(errors, 'marketing_consent')}>
        <input
          type="radio"
          onChange={(e) => setStateFromEvent('marketing_consent', e)}
          name="marketing_consent"
          value="yes"
          id="marketing_consent_yes"
        />
        <label htmlFor="marketing_consent_yes" className="errorable">Yes <span>I consent to receiving Aptible marketing emails</span></label>
      </div>

      <div className={errorClass(errors, 'marketing_consent')}>
        <input
          type="radio"
          onChange={(e) => setStateFromEvent('marketing_consent', e)}
          name="marketing_consent"
          value="no"
          id="marketing_consent_no"
        />
        <label htmlFor="marketing_consent_no" className="errorable">No <span>I don't want to receive marketing emails</span></label>
      </div>
    </div>

    <p className="small"><a href="/legal/privacy/" target="_blank">View the Aptible Privacy Statement</a></p>

    <button onClick={onSubmit}>Sign Up <i className="far fa-long-arrow-right"></i></button>
  </div>
);

export default Email;
