[![Stories in Ready](https://badge.waffle.io/lewagon/alumni.png?label=ready&title=Ready)](https://waffle.io/lewagon/alumni)
# Le Wagon Alumni

## React prerendering

While developing, you shall go faster by disabling back-end React rendering:

```bash
$ PRERENDER=false rails s
```

## Dependencies

```
brew install imagemagick
```

You need both **Redis** and **Elasticsearch** running on your computer.

## Sidekiq

You can run background jobs with a new terminal open and:

```bash
$ sidekiq
```

## ElasticSearch

To reindex all models, just run:

```bash
$ rake searchkick:reindex:all
```

## Figaro

You need to `touch config/application.yml` after your `git clone`. Here are the keys you need:

```yaml
DEVISE_SECRET_KEY: "youcanputwhateveryourwanthere"
```

Register a new [GitHub app](https://github.com/settings/developers) and put those keys:

```yaml
GITHUB_APP_ID: "aaaaaaaaaaaaaaaaaa"
GITHUB_APP_SECRET: "aaaaaaaaaaaaaa"
```

To get the Slack presence of users, you need to set an Slack token.

```yaml
SLACK_ALUMNI_ADMIN_TOKEN: "aaaaaaaaaa"
```

To seed, you need the ProductHunt API. Go to [http://www.producthunt.com/v1/oauth/applications](API Dashboard) and
create a new app. Then create a **developer token**.

```yaml
PH_TOKEN: 'aaaaaaaaaaaaaa'
```

## Schema

You can load [db/schema.xml](db/schema.xml) into [db.lewagon.org](http://db.lewagon.org).
