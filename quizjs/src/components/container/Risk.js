import React, { Component } from 'react';
import RiskPresentation from '../presentation/Risk';
import QUIZ_DATA from '../../quiz_data.json';

class Risk extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  static className() {
    return 'Risk';
  }

  recordAnswer = (question, answer) => {
    this.setState({ [question]: answer });
  }

  validate = () => {
    // const allQuestions = QUIZ_DATA.risk.questions.map((q) => q.id);
    // const answeredQuestions = Object.keys(this.state);
    return true;
  }

  onSubmit = () => {
    if (this.validate()) {
      this.score();
    }
  }

  score = () => {
    const sectionScore = {
      section: 'risk',
      grade: null,
      answers: []
    };

    for (let question of QUIZ_DATA.risk.questions) {
      let answer = this.state[question.id];
      if (answer !== undefined) {
        if (question.inverted) {
          answer = 4 - answer;
        }
        sectionScore.answers.push({ [question.id]: answer });
      }
    }

    sectionScore.grade = this.gradeScore(QUIZ_DATA.risk, sectionScore.answers);
    this.props.nextStep(sectionScore);
  }

  gradeScore = (section, answers) => {
    const maxScore = (section.questions.length * 4);
    const answerValues = answers.map((x) => Object.values(x)[0]);
    const answerSum = answerValues.reduce((a, b) => a + b, 0)
    const percentage = Math.round((answerSum / maxScore) * 100);

    for (let grade in section.scoring) {
      if (percentage >= section.scoring[grade][0] && percentage <= section.scoring[grade][1]) {
        return grade;
      }
    }
  }

  render() {
    return (
      <RiskPresentation
        questions={QUIZ_DATA.risk.questions}
        recordAnswer={this.recordAnswer}
        onSubmit={this.onSubmit}
      />
    );
  }
}

export default Risk;
