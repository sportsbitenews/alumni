json.partial! "posts/post", post: question
json.content render_markdown(question.content)
