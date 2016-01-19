json.answers do
  json.array! answers.order(created_at: :asc).map do |answer|
    json.partial! 'answers/answer', answer: answer
  end
end
