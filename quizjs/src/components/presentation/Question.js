import React from 'react';
import LikertLabels from './LikertLabels';
import Likert from './Likert';

const Question = ({ question, recordAnswer }) => (
  <div className="quiz__question">
    <p className="quiz__question-text">{question.text}</p>
    <LikertLabels type={question.type} />
    <Likert questionId={question.id} recordAnswer={recordAnswer} />
  </div>
);

export default Question;
