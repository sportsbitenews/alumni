users = YAML.load_file('db/users_dump.yml')

paris    = City.create! name: 'Paris'
brussels = City.create! name: 'Brussels'
lille    = City.create! name: 'Lille'
beirut   = City.create! name: 'Beirut'
bordeaux = City.create! name: 'Bordeaux'


Batch.create! slug: 1, city: paris, starts_at: Date.new(2014, 1, 6), slack_id: 'C03302GJ9'
Batch.create! slug: 2, city: paris, starts_at: Date.new(2014, 3, 7), slack_id: 'C032KMS4A'
Batch.create! slug: 3, city: paris, starts_at: Date.new(2014, 7, 7), slack_id: 'C032J80M0'
Batch.create! slug: 4, city: paris, starts_at: Date.new(2014, 10, 6), slack_id: 'C02QKRX85'
Batch.create! slug: 5, city: paris, starts_at: Date.new(2014, 10, 20), slack_id: 'C02QK0ZF2'
Batch.create! slug: 6, city: paris, starts_at: Date.new(2015, 1, 5), slack_id: 'C0393G6N4'
Batch.create! slug: 7, city: brussels, starts_at: Date.new(2015, 1, 12), slack_id: 'C03579S5S'
Batch.create! slug: 8, city: paris, starts_at: Date.new(2015, 3, 9), slack_id: 'C03T3CETW'
Batch.create! slug: 9, city: brussels, starts_at: Date.new(2015, 5, 4), slack_id: 'C04F6PW7Y'
Batch.create! slug: 10, city: paris, starts_at: Date.new(2015, 5, 11), slack_id: 'C04HMSHSE'
Batch.create! slug: 11, city: paris, starts_at: Date.new(2015, 7, 13), slack_id: 'C07FSQBUL'
Batch.create! slug: 12, city: brussels, starts_at: Date.new(2015, 8, 17), slack_id: 'C08TA6HFV'
Batch.create! slug: 13, city: lille, starts_at: Date.new(2015, 9, 7), slack_id: 'C09QAE7BN'
Batch.create! slug: 14, city: beirut, starts_at: Date.new(2015, 9, 14), slack_id: 'C09QAQ4C9'
Batch.create! slug: 15, city: paris, starts_at: Date.new(2015, 9, 21), slack_id: 'C09QAJ8EQ'

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

posts = YAML.load_file(File.join(Rails.root, 'db', 'posts_dumb.yml'))
posts.each do |p|
  post = p['type'].constantize.new
  post.title = p['title']
  post.user = User.find_by(github_nickname: p['author'])

  case p['type']
  when 'Resource'
    post.url = p['url']
    post.tagline = p['tagline']
  when 'Question'
    post.content = p['content']
  end
  post.save

  if p['type'] == 'Question'
    p['answers'].map do |a|
      answer = post.answers.create!(user: User.find_by(github_nickname: a['author']), content: a['content'])
    end
  end

end
