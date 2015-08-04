json.partial! 'posts/post', post: @post
json.partial! 'answers/index', answers: @post.answers