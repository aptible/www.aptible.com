import React from 'react';
import { errorClass } from '../../lib/errors';

const Profile = ({name, role, company_name, company_url, company_size, onSubmit, errors, setStateFromEvent}) => (
  <div className="signup__step">
    <h2>Complete Your Profile</h2>
    <p className="text-center">
      We need a few more details to start getting Gridiron set up for you.
    </p>

    <div className="signup__step__row">
      <div className="signup__step__row__half signup__step__row__half--left">
        <label htmlFor="signup-name">Your name</label>
        <input
          type="text"
          id="signup-name"
          value={name}
          className={errorClass(errors, 'name')}
          onChange={(e) => setStateFromEvent('name', e)} 
        />
      </div>
      <div className="signup__step__row__half signup__step__row__half--right">
        <label htmlFor="signup-role">Your role</label>
        <input
          type="text"
          id="signup-role"
          value={role}
          className={errorClass(errors, 'role')}
          onChange={(e) => setStateFromEvent('role', e)}
        />
      </div>
    </div>

    <label htmlFor="signup-company-name">Company</label>
    <input
      type="text"
      id="signup-company-name"
      value={company_name}
      className={errorClass(errors, 'company_name')}
      onChange={(e) => setStateFromEvent('company_name', e)}
    />

    <label htmlFor="signup-company-url">Company URL</label>
    <input
      type="text"
      id="signup-company-url"
      value={company_url}
      className={errorClass(errors, 'company_url')}
      onChange={(e) => setStateFromEvent('company_url', e)}
    />

    <label htmlFor="signup-company-size">Company size</label>
    <div className="signup__select-container">
      <select
        id="signup-company-size"
        value={company_size}
        className={errorClass(errors, 'company_size')}
        onChange={(e) => setStateFromEvent('company_size', e)}
      >
        <option value="">Select...</option>
        <option value="1-10">1-10 employees</option>
        <option value="11-20">11-20 employees</option>
        <option value="21-50">21-50 employees</option>
        <option value="51-100">51-100 employees</option>
        <option value="101-200">101-200 employees</option>
        <option value="201-500">201-500 employees</option>
        <option value="501-1,000">501-1,000 employees</option>
        <option value="1,000+">1,000+ employees</option>
      </select>
    </div>

    <button onClick={onSubmit}>Finish <i className="far fa-long-arrow-right"></i></button>
  </div>
);

export default Profile;
