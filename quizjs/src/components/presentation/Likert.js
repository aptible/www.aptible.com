import React from 'react';

const Likert = ({ questionId, recordAnswer }) => (
  <div className="quiz__likert-options">
    <div className="quiz__likert-option">
      <label for={`question-${questionId}-0`}>
        <input type="radio" id={`question-${questionId}-0`} name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 0)} />
      </label>
    </div>
    <div className="quiz__likert-option">
      <label for={`question-${questionId}-1`}>
        <input type="radio" id={`question-${questionId}-1`} name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 1)} />
      </label>
    </div>
    <div className="quiz__likert-option">
      <label for={`question-${questionId}-2`}>
        <input type="radio" id={`question-${questionId}-2`} name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 2)} />
      </label>
    </div>
    <div className="quiz__likert-option">
      <label for={`question-${questionId}-3`}>
        <input type="radio" id={`question-${questionId}-3`} name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 3)} />
      </label>
    </div>
    <div className="quiz__likert-option">
      <label for={`question-${questionId}-4`}>
        <input type="radio" id={`question-${questionId}-4`} name={`question-${questionId}`} onChange={() => recordAnswer(questionId, 4)} />
      </label>
    </div>
  </div>
);

export default Likert;
