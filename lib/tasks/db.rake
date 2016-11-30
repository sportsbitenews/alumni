namespace :db do
  desc "Dump AWS production DB and restore it locally."
  task import_from_aws: [ :environment, :create ] do
    c = Rails.configuration.database_configuration[Rails.env]
    Bundler.with_clean_env do
      puts "[1/4] Fetching DB password from AWS"
      db_url = `heroku config:get DATABASE_URL`
      uri = URI(db_url)
      db_password = uri.password

      puts "[2/4] Dumping DB"
      `PGPASSWORD=#{db_password} pg_dump -h #{uri.host} -U alumni -d alumni -F c -b -v -f tmp/alumni_prod_rds.dump`

      puts "[3/4] Restoring dump on local database"
      `pg_restore --clean --verbose --no-acl --no-owner -h localhost -d #{c["database"]} tmp/alumni_prod_rds.dump`

      puts "[4/4] Removing local backup"
      `rm tmp/alumni_prod_rds.dump`
      puts "Done."
    end
  end
end
