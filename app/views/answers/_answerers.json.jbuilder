json.answerers do
  json.array! answers.each do |answer|
    json.extract! answer.user, *user_properties
    json.thumbnail answer.user.thumbnail(width: 42, heigth: 42, crop: :fill)
  end
end
