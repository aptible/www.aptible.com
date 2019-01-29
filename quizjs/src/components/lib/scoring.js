export function unAnsweredQuestions(section, answers) {
  const allQuestions = section.questions.map((q) => q.id);
  const answeredQuestions = Object.keys(answers);

  return allQuestions.filter((x) => answeredQuestions.indexOf(x) === -1);
}


export function collectAnswers(section, state) {
  const answers = [];

  for (let question of section.questions) {
    let answer = state[question.id];
    if (answer !== undefined) {
      answers.push(answer);
    }
  }

  return answers;
}


export function scoreSection(section, answers) {
  const answersWithInverted = [];

  for (let [idx, question] of section.questions.entries()) {
    let answer = answers[idx];
    if (answer !== undefined) {
      if (question.inverted) {
        answer = 4 - answer;
      }

      answersWithInverted.push(answer);
    }
  }

  return {
    scoring: gradeScore(section.questions, answersWithInverted, section.scoring),
    answers: answers
  }
}


export function scoreOverall(quiz, answersBySection) {
  let questions = [];
  let answers = [];

  const scoring = {
    A: { range: [80, 100] },
    B: { range: [50, 79] },
    C: { range: [0, 49] }
  };

  for (let section in quiz) {
    questions = questions.concat(quiz[section].questions);
  }

  for (let section in answersBySection) {
    if (section === 'self')
      continue;

    answers = answers.concat(answersBySection[section]);
  }

  return gradeScore(questions, answers, scoring);
}


function gradeScore(questions, answers, scoring) {
  const maxScore = (questions.length * 4);
  const answerSum = answers.reduce((a, b) => a + b, 0)
  const percentage = Math.round((answerSum / maxScore) * 100);

  for (let grade in scoring) {
    if (percentage >= scoring[grade].range[0] && percentage <= scoring[grade].range[1]) {
      return {
        grade: grade,
        percentage: percentage
      }
    }
  }
}
