import React from 'react';
import Question from './Question';

const Business = ({ questions, recordAnswer, onSubmit }) => (
  <div className="quiz__step">
    <h2>Section 4: Business</h2>

    <div className="quiz__progress-bar">
      <div className="quiz__progress-bar__item quiz__progress-bar__item--completed"></div>
      <div className="quiz__progress-bar__item quiz__progress-bar__item--completed"></div>
      <div className="quiz__progress-bar__item quiz__progress-bar__item--completed"></div>
      <div className="quiz__progress-bar__item quiz__progress-bar__item--current"></div>
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
      <button onClick={onSubmit}>View Results <i className="far fa-long-arrow-right"></i></button>
    </div>
  </div>
);

export default Business;
