export function unAnsweredQuestions(section, answers) {
  const allQuestions = section.questions.map((q) => q.id);
  const answeredQuestions = Object.keys(answers);

  return allQuestions.filter((x) => answeredQuestions.indexOf(x) === -1);
}


export function scoreSection(sectionName, section, answers) {
  const sectionScore = {
    section: sectionName,
    grade: null,
    answers: []
  };

  for (let question of section.questions) {
    let answer = answers[question.id];
    if (answer !== undefined) {
      if (question.inverted) {
        answer = 4 - answer;
      }
      sectionScore.answers.push({ [question.id]: answer });
    }
  }

  sectionScore.grade = gradeScore(section, sectionScore.answers);
  return sectionScore;
}


function gradeScore(section, answers) {
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
