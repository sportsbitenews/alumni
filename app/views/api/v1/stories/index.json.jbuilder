json.stories do
  json.array! @stories do |story|
    json.partial! 'story', story: story
  end
end
