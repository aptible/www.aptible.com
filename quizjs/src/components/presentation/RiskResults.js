import React from 'react';
import ResultsActionItems from './ResultsActionItems';
import QUIZ_DATA from '../../quiz_data.json';

const RiskResults = ({ score }) => (
  <div className="quiz__results__section">
    <h3>Risk: {score.grade}</h3>
    <p>{QUIZ_DATA.risk.scoring[score.grade].summary}</p>

    <ResultsActionItems />
  </div>
);

export default RiskResults;
