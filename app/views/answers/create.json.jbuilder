json.partial! 'posts/post', post: @post
json.partial! 'answers/index', answers: @post.answers
json.answerers do
  json.array! @post.answers.map do |answer|
    json.extract! answer.user, :id, :thumbnail, :github_nickname
  end
end
