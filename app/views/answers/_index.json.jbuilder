json.answers do
  json.array! answers.map do |answer|
    json.partial! 'answers/answer', answer: answer
  end
end
