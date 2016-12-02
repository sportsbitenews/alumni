json.partial! "posts/post", post: resource, thumbnail: defined?(thumbnail) ? thumbnail : true
json.screenshot_url resource.screenshot_url
json.tagline resource.tagline
json.url resource.url
