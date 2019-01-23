import React from 'react';
import Question from './Question';

const Risk = ({ questions, recordAnswer, onSubmit }) => (
  <div className="quiz__step">
    <h2>Section 1: Risk</h2>

    <div className="quiz__progress-bar">
      <div className="quiz__progress-bar__item quiz__progress-bar__item--current"></div>
      <div className="quiz__progress-bar__item"></div>
      <div className="quiz__progress-bar__item"></div>
      <div className="quiz__progress-bar__item"></div>
    </div>

    <h3>
      Answer a few questions about how your team acts towards and thinks about security, and 
      help you identify areas where you can improve.
    </h3>

    {questions.map((question, idx) => (
      <Question
        key={idx}
        question={question}
        recordAnswer={recordAnswer}
      />
    ))}

    <div className="quiz__button--next">
      <button onClick={onSubmit}>Next Section <i className="far fa-long-arrow-right"></i></button>
    </div>
  </div>
);

export default Risk;
