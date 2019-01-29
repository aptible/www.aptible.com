import React from 'react';
import QUIZ_DATA from '../../quiz_data.json';

const RiskResults = ({ score }) => (
  <div className="quiz__results__section">
    <h3>Risk: {score.grade}</h3>
    <p>{QUIZ_DATA.risk.scoring[score.grade].summary}</p>

    {QUIZ_DATA.risk.scoring[score.grade].recommendations &&
      <div>
        <h4>Recommendations:</h4>
        <p>{QUIZ_DATA.risk.scoring[score.grade].recommendations}</p>
      </div>
    }
  </div>
);

export default RiskResults;
