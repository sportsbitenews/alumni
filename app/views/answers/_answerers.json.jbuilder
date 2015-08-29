json.answerers do
  json.array! answers.each do |answer|
    json.extract! answer.user, *user_properties
  end
end
