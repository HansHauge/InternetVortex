class UpdateRssFeedsJob < ActiveJob::Base
  attr_accessor :r_jokes_feed, :chive_article_feed
  queue_as :default
  TIME_TO_WAIT = 5.minutes

  def perform
    update_r_jokes
    update_chive_article

    sleep TIME_TO_WAIT
    self.class.perform_now
  end

  def update_r_jokes
    if r_jokes_feed
      r_jokes_feed = Feedjira::Feed.update(r_jokes_feed)
      Joke.update_from_feed(r_jokes_feed.entries) if r_jokes_feed.updated?
    else
      r_jokes_feed = Feedjira::Feed.fetch_and_parse('http://www.reddit.com/r/jokes/.rss')
      Joke.update_from_feed(r_jokes_feed.entries)
    end
  end

  def update_chive_article
    if chive_article_feed
      chive_article_feed = Feedjira::Feed.update(chive_article_feed)
      ChiveArticle.update_from_feed(chive_article_feed.entries) if chive_article_feed.updated?
    else
      chive_article_feed = Feedjira::Feed.fetch_and_parse('http://thechive.com/category/funny_hilarious_photos_pictures/feed/')
      ChiveArticle.update_from_feed(chive_article_feed.entries)
    end
  end
end
