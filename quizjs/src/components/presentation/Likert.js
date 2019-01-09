import React from 'react';

const Likert = ({ questionId, recordAnswer }) => (
  <div className="quiz__likert-options">
    <div className="quiz__likert-option">
      <input type="radio" name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 0)} />
    </div>
    <div className="quiz__likert-option">
      <input type="radio" name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 1)} />
    </div>
    <div className="quiz__likert-option">
      <input type="radio" name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 2)} />
    </div>
    <div className="quiz__likert-option">
      <input type="radio" name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 3)} />
    </div>
    <div className="quiz__likert-option">
      <input type="radio" name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 4)} />
    </div>
  </div>
);

export default Likert;
