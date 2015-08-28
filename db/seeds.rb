# USER
  # using ui_face api + randomuser

30.times do
  random = JSON.load(open('https://randomuser.me/api'))['results'][0]['user']
  ui_face = JSON.load(open('http://uifaces.com/api/v1/random'))

  user = User.new
  user.gravatar_url = ui_face['image_urls']['epic']
  user.first_name = "#{random['name']['first']}"
  user.last_name = "#{random['name']['last']}"
  user.github_nickname = ui_face['username']
  user.email = random['email']
  user.alumni = true
  user.save(validate: false)
  puts "Welcome #{user.github_nickname}"
end


questions = YAML.load_file('db/support/questions.yml')
questions.each do |q|
  question = Question.new
  question.title = q['title']
  question.user = User.random
  question.content = q['content']
  question.save
  puts "Question ##{question.id} created"
end

resources = JSON.load(open("https://api.producthunt.com/v1/posts?access_token=#{ENV['PH_TOKEN']}"))
resources['posts'].each do |r|
  resource = Resource.new
  resource.title = r['name']
  resource.url = r['redirect_url']
  resource.screenshot_url = r['screenshot_url']['850px']
  resource.tagline = r['tagline']
  resource.user = User.random
  resource.save

  puts "#{resource.title} created"
end

paris = City.new
paris.name = "Paris"
paris.save

batch = Batch.new
batch.starts_at = Date.new(2014, 7, 4)
batch.city = paris
batch.name = "Promo #3"
batch.save

User.all.sample(25).each do |user|
  u = user
  u.batch = batch
  u.save
end

projects = YAML.load_file('db/support/projects.yml')
projects.each do |p|
  batch = Batch.first
  project = Project.new
  project.url = p['link']
  project.name = p['name']
  project.tagline = p['tagline']
  project.batch = batch
  project.users << User.random * Random.rand(1..2)
  project.save
end


