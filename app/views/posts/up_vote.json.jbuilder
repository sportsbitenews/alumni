type = @post.class.to_s.underscore
json.partial! "#{type.pluralize}/#{type}", { type.to_sym => @post }
json.answers do
  json.array! @post.answers.each do |answer|
    json.partial! "answers/answer", answer: answer
  end
end
