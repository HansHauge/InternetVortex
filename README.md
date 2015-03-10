# InternetVortex

After deploy, we need to set up the cron jobs:

`whenever --update-crontab InternetVortex`
`crontab -l`

Also don't forget to update the environment:

`config/schedule.rb`
`set :environment, "development"` (should be changed to production)

If the cron jobs get messed up:

`crontab -r`

Also we need to turn on the redis server:

`redis-server`

To refresh the sitemap (needs to be added to cron):

`rake sitemap:refresh`

or:

`rake sitemap:refresh:no_ping` (don't ping search engines)
