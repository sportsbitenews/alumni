json.partial! "posts/post", post: question
enriched_content = question.content.dup
question.content.scan(/\B@\S*/).flatten.uniq.each do |mention|
  enriched_content.gsub!(/\B#{mention}/, "**[#{mention}](/#{mention[1..-1]})**").gsub(/\r\n/, "\n")
end
json.content render_markdown(enriched_content)
json.original_content question.content.gsub(/\r\n/, "\n")
json.solved question.solved
