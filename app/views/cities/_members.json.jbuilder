json.members do
  json.array! members do |member|
    json.full_name member.first_name + ' ' + member.last_name
    json.bio_en member.bio_en
    json.bio_fr member.bio_fr
    json.role member.role
    json.github_nickname member.github_nickname
    json.twitter_nickname member.twitter_nickname
    json.thumbnail member.thumbnail(width: 42, height: 42, crop: :fill)
    json.ordered_list_id ordered_list.id
  end
end
json.position position
json.ordered_list_id ordered_list.id
