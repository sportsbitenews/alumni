json.resources do
  json.array! @posts[:resources] do |resource|
    json.partial! "resources/resource", resource: resource
  end
end

json.questions do
  json.array! @posts[:questions] do |question|
    json.partial! "questions/question", question: question
  end
end

json.jobs do
  json.array! @posts[:jobs] do |job|
    json.partial! "jobs/job", job: job
  end
end
