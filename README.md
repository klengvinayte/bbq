# BBQ

BBQ is an application that helps to organize events. Create your own event and gather people around you or go to someone else's event. Subscribe to the alert and don't miss anything important. Share your photos and impressions in the comments. If you have an event for your own only, you can protect it with a PIN code.

The application was created on Ruby 3.1.2 and Ruby on Rails 7.0.4

### Required to run the application

`Ruby` and `Node` installed. `SQLite3` is used for data storage in development. A `Redis` database is also needed.

Before launching, you need to configure `.env` file.

```
MAILJET_API_KEY=your_key
MAILJET_SECRET_KEY=your_key
MAILJET_DEFAULT_FROM=your_email

S3_ACCESS_KEY=your_key
S3_SECRET_KEY=your_key
S3_BUCKET_NAME=your_bucket_name
S3_REGION=your_region
```

You can use the vim or nano editor

Next, you need to run the following commands:

```
$ bundle
$ rails db:migrate
$ yarn build
$ yarn build:css
```

Run app:

```
$ rails s
```

And visit `http://localhost:3000`.

### Additional features

If you want to be able to log in using [GitHub OAuth](https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps) and [Google OAuth](https://console.cloud.google.com/welcome?project=bbq-klengvinayte-1673508143249), you need to connect the application to the appropriate service. Then specify in `.env`:

```
PROD_OMNIAUTH_GITHUB_ID=your_key
PROD_OMNIAUTH_GITHUB_SECRET=your_key

PROD_GOOGLE_CLIENT_ID=your_key
PROD_GOOGLE_CLIENT_SECRET=your_key
```

### Database in production

In the `production` environment, you must specify the database login and password in the environment variables `PG_DATABASE`, `PG_USER` and `PG_RASSWORD` or specify explicitly in `.env`

```
production:
  adapter: postgresql
  user: <%= ENV['PG_USER'] %>
  password: <%= ENV['PG_RASSWORD'] %>
  database: <%= ENV['PG_DATABASE'] %>
```
