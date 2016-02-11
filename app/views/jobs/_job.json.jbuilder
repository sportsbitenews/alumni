json.partial! "posts/post", post: job
json.city job.city
json.company job.company
json.contact_email job.contact_email
json.ad_url job.ad_url
enriched_content = job.description.dup
job.description.scan(/\B@\S*/).flatten.uniq.each do |mention|
  enriched_content.gsub!(/\B#{mention}/, "**[#{mention}](/#{mention[1..-1]})**").gsub(/\r\n/, "\n")
end
json.content render_markdown(enriched_content)
json.original_content job.description.gsub(/\r\n/, "\n")
