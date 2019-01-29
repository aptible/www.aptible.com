import React from 'react';
import QUIZ_DATA from '../../quiz_data.json';

const TrustResults = ({ score }) => (
  <div className="quiz__results__section">
    <h3>Trust: {score.grade}</h3>
    <p>{QUIZ_DATA.trust.scoring[score.grade].summary}</p>

    {QUIZ_DATA.trust.scoring[score.grade].recommendations &&
      <div>
        <h4>Recommendations:</h4>
        <p>{QUIZ_DATA.trust.scoring[score.grade].recommendations}</p>
      </div>
    }
  </div>
);

export default TrustResults;
