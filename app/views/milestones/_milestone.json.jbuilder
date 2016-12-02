json.partial! "posts/post", post: milestone, thumbnail: defined?(thumbnail) ? thumbnail : true
json.content render_markdown(enriched_content(milestone.content))
json.original_content milestone.content.gsub(/\r\n/, "\n")
json.date milestone.created_at.strftime('%B %Y')
json.project_name milestone.project.name
json.project_id milestone.project.id
