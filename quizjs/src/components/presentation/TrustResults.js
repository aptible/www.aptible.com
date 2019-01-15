import React from 'react';
import ResultsActionItems from './ResultsActionItems';
import QUIZ_DATA from '../../quiz_data.json';

const TrustResults = ({ score }) => (
  <div className="quiz__results__section">
    <h3>Trust: {score.grade}</h3>
    <p>{QUIZ_DATA.trust.scoring[score.grade].summary}</p>

    <ResultsActionItems/>
  </div>
);

export default TrustResults;
