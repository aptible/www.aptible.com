import React from 'react';

const LABELS_FOR_TYPE = {
  action: ['Rarely or never', '', 'Sometimes', '', 'Frequently'],
  attitude: ['Strongly disagree', '', '', '', 'Strongly agree'],
  self_assessment: ['Needs Improvement', '', 'Average', '', 'Very Good']
};

const LikertLabels = ({ type }) => (
  <div className="quiz__likert-scale-labels">
    {LABELS_FOR_TYPE[type].map((label, idx) => (
      <div key={idx} className="quiz__likert-scale-label">{label}</div>
    ))}
  </div>
);

export default LikertLabels;
