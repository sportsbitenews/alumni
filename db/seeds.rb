users = YAML.load_file('db/users_dump.yml')
projects = YAML.load_file('db/projects_dump.yml')

City.create! name: 'Paris'
City.create! name: 'Bruxelles'
City.create! name: 'Lille'
City.create! name: 'Beyrouth'
City.create! name: 'Bordeaux'

Batch.create! slug: 1, city_id: 1, starts_at: Date.new(2014, 1, 6)
Batch.create! slug: 2, city_id: 2, starts_at: Date.new(2014, 3, 7)
Batch.create! slug: 3, city_id: 1, starts_at: Date.new(2014, 7, 7)
Batch.create! slug: 4, city_id: 1, starts_at: Date.new(2014, 10, 6)
Batch.create! slug: 5, city_id: 1, starts_at: Date.new(2014, 10, 20)
Batch.create! slug: 6, city_id: 1, starts_at: Date.new(2015, 1, 5)
Batch.create! slug: 7, city_id: 2, starts_at: Date.new(2015, 1, 12)
Batch.create! slug: 8, city_id: 1, starts_at: Date.new(2015, 3, 9)
Batch.create! slug: 9, city_id: 2, starts_at: Date.new(2015, 5, 4)
Batch.create! slug: 10, city_id: 1, starts_at: Date.new(2015, 5, 11)
Batch.create! slug: 11, city_id: 1, starts_at: Date.new(2015, 7, 13)
Batch.create! slug: 12, city_id: 2, starts_at: Date.new(2015, 8, 17)
Batch.create! slug: 13, city_id: 3, starts_at: Date.new(2015, 9, 7)
Batch.create! slug: 14, city_id: 4, starts_at: Date.new(2015, 9, 14)

users.each do |u|
  user = User.new
  user.first_name = u['first_name']
  user.last_name = u['last_name']
  user.gravatar_url = u['gravatar_url']
  user.github_nickname = u['github_nickname']
  user.batch = Batch.find_by(slug: u['batch_slug'])
  user.email = u['email']
  user.uid = u['github_uid']
  user.save
end

projects.each do |p|
  project = Project.new
  project.name = p['name']
  project.batch = Batch.find_by(slug: p['batch_slug'])
  project.tagline = p['tagline']
  project.url = p['url']
  p['makers'].each do |maker|
    if User.find_by(github_nickname: maker)
      project.users << User.find_by(github_nickname: maker)
    else
      puts User.find_by(github_nickname: maker)
    end
  end
  project.save
end



# # USER
#   # using ui_face api + randomuser

# 30.times do
#   random = JSON.load(open('https://randomuser.me/api'))['results'][0]['user']
#   ui_face = JSON.load(open('http://uifaces.com/api/v1/random'))

#   user = User.new
#   user.gravatar_url = ui_face['image_urls']['epic']
#   user.first_name = "#{random['name']['first']}"
#   user.last_name = "#{random['name']['last']}"
#   user.github_nickname = ui_face['username']
#   user.email = random['email']
#   user.alumni = true
#   user.save(validate: false)
#   puts "Welcome #{user.github_nickname}"
# end


# questions = YAML.load_file('db/support/questions.yml')
# questions.each do |q|
#   question = Question.new
#   question.title = q['title']
#   question.user = User.random
#   question.content = q['content']
#   question.save
#   puts "Question ##{question.id} created"
# end

# resources = JSON.load(open("https://api.producthunt.com/v1/posts?access_token=#{ENV['PH_TOKEN']}"))
# resources['posts'].each do |r|
#   resource = Resource.new
#   resource.title = r['name']
#   resource.url = r['redirect_url']
#   resource.screenshot_url = r['screenshot_url']['850px']
#   resource.tagline = r['tagline']
#   resource.user = User.random
#   resource.save

#   puts "#{resource.title} created"
# end

# paris = City.new
# paris.name = "Paris"
# paris.save

# batch = Batch.new
# batch.starts_at = Date.new(2014, 7, 4)
# batch.city = paris
# batch.name = "Batch #3"
# batch.save

# User.all.sample(25).each do |user|
#   u = user
#   u.batch = batch
#   u.save
# end

# projects = YAML.load_file('db/support/projects.yml')
# projects.each do |p|
#   batch = Batch.first
#   project = Project.new
#   project.url = p['link']
#   project.name = p['name']
#   project.tagline = p['tagline']
#   project.batch = batch
#   Random.rand(1..2).times { project.users << User.random }
#   project.save
# end


