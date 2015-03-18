# InternetVortex

In dev we are using whenever for cron, in production we use scheduler (heroku addon)

`whenever --update-crontab InternetVortex`
`crontab -l`

If the cron jobs get messed up:

`crontab -r`

If you need to turn on redis-server in dev:

`redis-server`

To refresh the sitemap (this task is scheduled already and happens once a day):

`rake sitemap:refresh`

or:

`rake sitemap:refresh:no_ping` (don't ping search engines, for development environment)

Before pushing to heroku you should compile the assets:

`RAILS_ENV=production bundle exec rake assets:precompile`

To start mysql locally:

`mysql.server start`