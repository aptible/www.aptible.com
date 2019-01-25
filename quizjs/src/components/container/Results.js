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
    const analyticsPayload = {};

    for (let sectionName in QUIZ_DATA) {
      if (answers[sectionName]) {
        results.sectionScores[sectionName] = scoreSection(QUIZ_DATA[sectionName], answers[sectionName]);
        analyticsPayload[`${sectionName}_grade`] = results.sectionScores[sectionName].scoring.grade;
        analyticsPayload[`${sectionName}_percentage`] = results.sectionScores[sectionName].scoring.percentage;
      }
    }

    results.overallScoring = scoreOverall(QUIZ_DATA, answers);

    const selfAssessmentScore = this.scoreSelfAssessment(answers.self[0]);
    results.selfAssessmentGrade = selfAssessmentScore.grade;
    results.selfAssessmentDescription = selfAssessmentScore.description;

    // Record the letter grade and percentage of each section + overall
    analyticsPayload.overall_grade = results.overallScoring.grade;
    analyticsPayload.overall_percentage = results.overallScoring.percentage;
    if (answers.self) {
      analyticsPayload.self_assessment = answers.self[0];
    }

    aptible.analytics.event('Quiz Data', analyticsPayload);

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

  scoreSelfAssessment = (assessment) => {
    const scores = {
      0: { grade: 'C', description: 'Needs Improvement' },
      1: { grade: 'C', description: 'Needs Improvement' },
      2: { grade: 'B', description: 'Average' },
      3: { grade: 'B', description: 'Average' },
      4: { grade: 'A', description: 'Very Good' }
    }

    return scores[assessment];
  }

  render() {
    return (
      <ResultsPresentation
        scores={this.state.sectionScores}
        overallGrade={this.state.overallScoring.grade}
        selfAssessmentGrade={this.state.selfAssessmentGrade}
        selfAssessmentDescription={this.state.selfAssessmentDescription}
      />
    );
  }
}

export default Results;
