if posts.empty?
  json.array! []
else
  type = posts.first.class.to_s.underscore

  json.array! posts do |post|
    json.partial! "#{type}s/#{type}", :"#{type}" => post
  end
end
