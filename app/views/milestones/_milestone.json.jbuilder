json.partial! "posts/post", post: milestone
enriched_content = milestone.content.dup
milestone.content.scan(/\B@\S*/).flatten.uniq.each do |mention|
  enriched_content.gsub!(/\B#{mention}/, "**[#{mention}](/#{mention[1..-1]})**").gsub(/\r\n/, "\n")
end
json.content render_markdown(enriched_content)
json.original_content milestone.content.gsub(/\r\n/, "\n")
json.date milestone.created_at.strftime('%B %Y')

