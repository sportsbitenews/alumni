type = @post.class.to_s.underscore
json.partial! "#{type.pluralize}/#{type}", { type.to_sym => @post }
