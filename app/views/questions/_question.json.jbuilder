json.partial! "posts/post", post: question, thumbnail: defined?(thumbnail) ? thumbnail : true
json.content render_markdown(enriched_content(question.content))
json.original_content question.content.gsub(/\r\n/, "\n")
json.solved question.solved
