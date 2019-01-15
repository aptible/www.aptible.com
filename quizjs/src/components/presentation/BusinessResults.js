import React from 'react';
import ResultsActionItems from './ResultsActionItems';
import QUIZ_DATA from '../../quiz_data.json';

const BusinessResults = ({ score }) => (
  <div className="quiz__results__section">
    <h3>Business: {score.grade}</h3>
    <p>{QUIZ_DATA.business.scoring[score.grade].summary}</p>

    <ResultsActionItems />
  </div>
);

export default BusinessResults;
