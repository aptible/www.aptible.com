import React from 'react';
import RiskResults from './RiskResults'
import TrustResults from './TrustResults'
import ProcessResults from './ProcessResults'
import BusinessResults from './BusinessResults'

const Results = ({ scores, overallGrade, selfAssessmentGrade, selfAssessmentDescription }) => (
  <div className="quiz__results">
    <div className="quiz__results__content">
      <h1>Your overall score: {overallGrade}</h1>
      <p><strong>Your self assessment: {selfAssessmentGrade} ({selfAssessmentDescription})</strong></p>
      <p>
        See our recommendations for how to better prepare for an information
        security audit below.
      </p>

      <p>Share the results with your team:</p>
      <input value={`${window.location.href}&quizid=9KdgqVFyMMeobjGiq5BumpcgiDjgFBxb7AP2w5SbAhxg1R8n`} onChange={() => ''} />

      <div className="quiz__results__sections">
        <RiskResults score={scores.risk.scoring} />
        <TrustResults score={scores.trust.scoring} />
        <ProcessResults score={scores.process.scoring} />
        <BusinessResults score={scores.business.scoring} />
      </div>
    </div>

    <div className="quiz__results__sidebar">
      <div className="quiz__results__sidebar__content">
        <h2>Go from zero to audit-ready with Aptible Gridiron</h2>
        <p>
          Gridiron makes it fast and easy to build an audit-ready information
          security management program that meets the requirements of:
        </p>
        <ul>
          <li>HIPAA</li>
          <li>GDPR</li>
          <li>SOC 2</li>
          <li>ISO 27001</li>
        </ul>

        <a href="/gridiron/" className="btn btn--gridiron">Learn More</a>
      </div>
    </div>
  </div>
);

export default Results;
