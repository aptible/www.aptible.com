import React from 'react';

const LABELS_FOR_TYPE = {
  action: ['Rarely or never', '', 'Sometimes', '', 'Always'],
  attitude: ['Strongly disagree', '', 'Sometimes', '', 'Strongly agree']
};

const LikertLabels = ({ type }) => (
  <div className="quiz__likert-scale-labels">
    {LABELS_FOR_TYPE[type].map((label, idx) => (
      <div key={idx} className="quiz__likert-scale-label">{label}</div>
    ))}
  </div>
);

export default LikertLabels;
