import React, { Component } from 'react';
import ResultsPresentation from '../presentation/Results';
import { scoreSection, scoreOverall } from '../lib/scoring';
import QUIZ_DATA from '../../quiz_data.json';

class Results extends Component {
  constructor(props) {
    super(props);
    this.state = this.scoreResults();
  }

  scoreResults = () => {
    const results = { sectionScores: {}, overallGrade: 'N/A' };
    const answers = this.parseResults();

    for (let sectionName in QUIZ_DATA) {
      if (answers[sectionName]) {
        results.sectionScores[sectionName] = scoreSection(QUIZ_DATA[sectionName], answers[sectionName]);
      }
    }

    results.overallGrade = scoreOverall(QUIZ_DATA, answers);

    return results;
  }

  parseResults = () => {
    const sections = window.location.search.substr(1).split('&');
    const results = {};

    for (let section of sections) {
      if (section.indexOf('=') === -1)
        continue;

      let [sectionName, answers] = section.split('=');
      results[sectionName] = answers.split(',').map((x) => parseInt(x));
    }

    return results;
  }

  render() {
    return (
      <ResultsPresentation
        scores={this.state.sectionScores}
        overallGrade={this.state.overallGrade}
      />
    );
  }
}

export default Results;
