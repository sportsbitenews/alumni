# USER
  # using ui_face api + randomuser

users = YAML.load_file('db/support/users.yml')
users.each do |user|
  random = JSON.load(open('https://randomuser.me/api'))['results'][0]['user']
  ui_face = JSON.load(open('http://uifaces.com/api/v1/random'))

  user = User.new
  user.gravatar_url = ui_face['image_urls']['epic']
  user.name = "#{random['name']['first']} #{random['name']['last']}"
  user.github_nickname = ui_face['username']
  user.email = random['email']
  user.alumni = true
  user.save(validate: false)
  puts "Welcome #{user.github_nickname}"
end

# POST
  # question
  # resource (using product hunt api)

questions = YAML.load_file('db/support/questions.yml')
questions.each do |q|
  question = Question.new
  question.title = q['title']
  user_id = Random.rand(User.all.size)
  question.save(validate: false)
  puts "Question ##{question.id} created"
end

resources = JSON.load(open('https://api.producthunt.com/v1/posts?access_token=eb6acb4f4e27efe77ba1b7ec885752d7df8f2c66e75c46a0f5dd7cb7a4a26279'))
resources['posts'].each do |r|
  resource = Resource.new
  resource.title = r['name']
  resource.url = r['redirect_url']
  resource.tagline = r['tagline']
  resource.user_id = Random.rand(User.all.size)
  resource.save(validate: false)

  puts "#{resource.title} created"
end