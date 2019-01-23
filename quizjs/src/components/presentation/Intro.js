import React from 'react';
import Question from './Question';

const Intro = ({ questions, recordAnswer, onSubmit }) => (
  <div className="quiz__step">
    <h2>Welcome!</h2>

    <h3>
      Tell us about your current security practices and attitudes, and we'll 
      give you recommendations on how you can improve.
    </h3>

    {questions.map((question, idx) => (
      <Question
        key={idx}
        question={question}
        recordAnswer={recordAnswer}
      />
    ))}

    <div className="quiz__button--next">
      <button onClick={onSubmit}>Start Assessment <i className="far fa-long-arrow-right"></i></button>
    </div>
  </div>
);

export default Intro;
