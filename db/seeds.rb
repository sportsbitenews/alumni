users = YAML.load_file('db/users_dump.yml')

paris = City.create! name: 'Paris'
xl = City.create! name: 'Bruxelles'
lille = City.create! name: 'Lille'
malik = City.create! name: 'Beyrouth'
bdx = City.create! name: 'Bordeaux'

Batch.create! slug: 1, city_id: 1, starts_at: Date.new(2014, 1, 6), ends_at:  Date.new(2014, 2, 7)
Batch.create! slug: 2, city_id: 2, starts_at: Date.new(2014, 3, 7), ends_at: Date.new(2014, 5, 30)
Batch.create! slug: 3, city_id: 1, starts_at: Date.new(2014, 7, 7), ends_at: Date.new(2014, 9, 5)
Batch.create! slug: 4, city_id: 1, starts_at: Date.new(2014, 10, 6), ends_at: Date.new(2014, 12, 5)
Batch.create! slug: 5, city_id: 1, starts_at: Date.new(2014, 10, 20), ends_at: Date.new(2014, 12, 19)
Batch.create! slug: 6, city_id: 1, starts_at: Date.new(2015, 1, 5), ends_at: Date.new(2015, 3, 6)
Batch.create! slug: 7, city_id: 2, starts_at: Date.new(2015, 1, 12), ends_at: Date.new(2015, 3, 13)
Batch.create! slug: 8, city_id: 1, starts_at: Date.new(2015, 3, 9), ends_at: Date.new(2015, 5, 8)
Batch.create! slug: 9, city_id: 2, starts_at: Date.new(2015, 5, 4), ends_at: Date.new(2015, 7, 3)
Batch.create! slug: 10, city_id: 1, starts_at: Date.new(2015, 5, 11), ends_at: Date.new(2015, 7, 10)
Batch.create! slug: 11, city_id: 1, starts_at: Date.new(2015, 7, 13), ends_at: Date.new(2015, 9, 11)
Batch.create! slug: 12, city_id: 2, starts_at: Date.new(2015, 8, 17), ends_at: Date.new(2015, 10, 16)
Batch.create! slug: 13, city_id: 3, starts_at: Date.new(2015, 9, 7), ends_at: Date.new(2015, 11, 6)
Batch.create! slug: 14, city_id: 4, starts_at: Date.new(2015, 9, 14) , ends_at: Date.new(2015, 11, 13)

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

projects = YAML.load_file('db/projects_dump.yml')
projects.each do |p|
  project = Project.find_or_create_by(name: p['name'])
  if p['cover_picture']
    project.cover_picture = p['cover_picture']
  end
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
  project.cover_picture.reprocess!
end

