json.set! :"#{@post_type.to_s.underscore.pluralize}" do
  json.partial! "index", posts: @posts
end
