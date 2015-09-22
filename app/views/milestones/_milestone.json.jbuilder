json.partial! "posts/post", post: milestone
json.content render_markdown(milestone.content)
json.original_content milestone.content
json.date milestone.created_at.strftime('%B %Y')

