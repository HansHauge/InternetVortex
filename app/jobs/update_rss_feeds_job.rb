class UpdateRssFeedsJob < ActiveJob::Base
  queue_as :default
  TIME_TO_WAIT = 5.minutes

  def perform(feed = nil)
    if feed
      feed = Feedjira::Feed.update(feed)
      Joke.update_from_feed(feed.entries) if feed.updated?
    else
      feed = Feedjira::Feed.fetch_and_parse('http://www.reddit.com/r/jokes/.rss')
      Joke.update_from_feed(feed.entries)
    end

    sleep TIME_TO_WAIT
    self.class.perform_now(feed)
  end
end
