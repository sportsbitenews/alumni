json.partial! "posts/post", post: milestone
json.content milestone.content
json.original_content post.content
json.date milestone.created_at.strftime('%B %Y')

