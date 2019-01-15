import React from 'react';
import ResultsActionItems from './ResultsActionItems';
import QUIZ_DATA from '../../quiz_data.json';

const ProcessResults = ({ score }) => (
  <div className="quiz__results__section">
    <h3>Process: {score.grade}</h3>
    <p>{QUIZ_DATA.process.scoring[score.grade].summary}</p>

    <ResultsActionItems />
  </div>
);

export default ProcessResults;
