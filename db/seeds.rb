users = YAML.load_file('db/support/users.yml')
users.each do |user|
  random = JSON.load(open('https://randomuser.me/api'))['results'][0]['user']
  ui_face = JSON.load(open('http://uifaces.com/api/v1/random')) # because randomuser face are ...

  user = User.new
  user.gravatar_url = ui_face['image_urls']['epic']
  user.name = "#{random['name']['first']} #{random['name']['last']}"
  user.github_nickname = ui_face['username']
  user.email = random['email']
  user.alumni = true
  user.save(validate: false)
  puts "Welcome #{user.github_nickname}"
end