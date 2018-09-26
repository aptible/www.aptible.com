import React from 'react';

const HowHeard = ({ how_heard, onSubmit, onSkip, setStateFromEvent }) => (
  <div className="signup__step">
    <h2>Quick Question...</h2>
    <p className="text-center">
      Before we move forward, can you tell us where you heard about Gridiron?
      This is tremendously helpful to us as we are evaluating our reach.
    </p>

    <label htmlFor="signup-how-heard">How did you hear about Gridiron?</label>
    <textarea id="signup-how-heard" value={how_heard} onChange={(e) => setStateFromEvent('how_heard', e)}>
    </textarea>

    <button onClick={onSubmit}>Next <i className="far fa-long-arrow-right"></i></button>
    <a className="signup__skip" onClick={onSkip}>Skip</a>
  </div>
);

export default HowHeard;
