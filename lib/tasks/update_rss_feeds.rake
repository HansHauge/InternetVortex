namespace :update_rss_feeds do
  desc "Updates all the feeds"
  task update_all: :environment do
    UpdateRssFeedsJob.perform_now
  end
end
