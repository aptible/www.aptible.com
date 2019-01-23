import React from 'react';
import QUIZ_DATA from '../../quiz_data.json';

const ProcessResults = ({ score }) => (
  <div className="quiz__results__section">
    <h3>Process: {score.grade}</h3>
    <p>{QUIZ_DATA.process.scoring[score.grade].summary}</p>

    {QUIZ_DATA.process.scoring[score.grade].recommendations &&
      <div>
        <h4>Recommendations:</h4>
        <p>{QUIZ_DATA.process.scoring[score.grade].recommendations}</p>
      </div>
    }
  </div>
);

export default ProcessResults;
