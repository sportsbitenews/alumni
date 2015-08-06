json.partial! "questions/question", question: @question
json.partial! 'answers/index', answers: @question.answers
