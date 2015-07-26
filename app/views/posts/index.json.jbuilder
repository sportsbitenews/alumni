json.posts do
  json.array! @posts do |post|
    type = post.class.to_s.underscore
    json.partial! "#{type.pluralize}/#{type}", { type.to_sym => post }
  end
end
