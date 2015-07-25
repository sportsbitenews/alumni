json.resources do
  json.array! @resources do |resource|
    json.extract! resource, :id, :title
    json.user do
      json.extract! resource.user, :id, :github_nickname
    end
    json.up_votes do
      json.array! resource.votes_for do |vote|
        json.extract! vote.voter, :id, :gravatar_url
      end
    end
  end
end
