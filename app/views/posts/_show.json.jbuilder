type = post.class.to_s.underscore

json.partial! "#{type.pluralize}/#{type}", { type.to_sym => post }
json.partial! "answers/index", answers: post.answers
json.partial! "answers/answerers", answers: post.answers
