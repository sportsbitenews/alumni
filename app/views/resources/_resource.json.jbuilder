json.partial! "posts/post", post: resource
json.tagline resource.tagline
json.url resource.url


json.partial! 'answers/index', answers: resource.answers