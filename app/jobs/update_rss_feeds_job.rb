class UpdateRssFeedsJob < ActiveJob::Base
  attr_accessor  :r_jokes_feed,
                 :chive_article_feed,
                 :buzzfeed_lol_article_feed,
                 :buzzfeed_fail_article_feed,
                 :memebase_feed,
                 :r_funny_pictures_feed,
                 :cracked_article_feed,
                 :break_video_feed

  queue_as :default
  TIME_TO_WAIT = 5.minutes

  def perform
    update_r_jokes
    update_chive_articles
    update_buzzfeed_lol_articles
    update_buzzfeed_fail_articles
    update_memebase_articles
    update_r_funny_pictures
    update_cracked_articles
    update_break_videos

    sleep TIME_TO_WAIT
    self.class.perform_now
  end

  def update_r_jokes
    if r_jokes_feed
      r_jokes_feed = Feedjira::Feed.update(r_jokes_feed)
      Joke.update_from_feed(r_jokes_feed.new_entries) if r_jokes_feed.updated?
    else
      r_jokes_feed = Feedjira::Feed.fetch_and_parse('http://www.reddit.com/r/jokes/.rss')
      Joke.update_from_feed(r_jokes_feed.entries)
    end
  end

  def update_chive_articles
    if chive_article_feed
      chive_article_feed = Feedjira::Feed.update(chive_article_feed)
      ChiveArticle.update_from_feed(chive_article_feed.new_entries) if chive_article_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      chive_article_feed = Feedjira::Feed.fetch_and_parse('http://thechive.com/category/funny_hilarious_photos_pictures/feed/')
      ChiveArticle.update_from_feed(chive_article_feed.entries)
    end
  end

  def update_buzzfeed_lol_articles
    if buzzfeed_lol_article_feed
      buzzfeed_lol_article_feed = Feedjira::Feed.update(buzzfeed_lol_article_feed)
      BuzzfeedArticle.update_from_feed(buzzfeed_lol_article_feed.new_entries) if buzzfeed_lol_article_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      buzzfeed_lol_article_feed = Feedjira::Feed.fetch_and_parse('http://www.buzzfeed.com/lol.xml')
      BuzzfeedArticle.update_from_feed(buzzfeed_lol_article_feed.entries)
    end
  end

  def update_buzzfeed_fail_articles
    if buzzfeed_fail_article_feed
      buzzfeed_fail_article_feed = Feedjira::Feed.update(buzzfeed_fail_article_feed)
      BuzzfeedArticle.update_from_feed(buzzfeed_fail_article_feed.new_entries) if buzzfeed_fail_article_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      buzzfeed_fail_article_feed = Feedjira::Feed.fetch_and_parse('http://www.buzzfeed.com/fail.xml')
      BuzzfeedArticle.update_from_feed(buzzfeed_fail_article_feed.entries)
    end
  end

  def update_memebase_articles
    if memebase_feed
      memebase_feed = Feedjira::Feed.update(memebase_feed)
      MemebaseArticle.update_from_feed(memebase_feed.new_entries) if memebase_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      memebase_feed = Feedjira::Feed.fetch_and_parse('http://feeds.feedblitz.com/Memebase&x=1')
      MemebaseArticle.update_from_feed(memebase_feed.entries)
    end
  end

  def update_r_funny_pictures
    if r_funny_pictures_feed
      r_funny_pictures_feed = Feedjira::Feed.update(r_funny_pictures_feed)
      RedditFunnyPicture.update_from_feed(r_funny_pictures_feed.new_entries) if r_funny_pictures_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      r_funny_pictures_feed = Feedjira::Feed.fetch_and_parse('https://www.reddit.com/r/funny/.rss')
      RedditFunnyPicture.update_from_feed(r_funny_pictures_feed.entries)
    end
  end

  def update_cracked_articles
    if cracked_article_feed
      cracked_article_feed = Feedjira::Feed.update(cracked_article_feed)
      CrackedArticle.update_from_feed(cracked_article_feed.new_entries) if cracked_article_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      cracked_article_feed = Feedjira::Feed.fetch_and_parse('http://feeds.feedburner.com/CrackedRSS')
      CrackedArticle.update_from_feed(cracked_article_feed.entries)
    end
  end

  def update_break_videos
    if break_video_feed
      break_video_feed = Feedjira::Feed.update(break_video_feed)
      BreakVideo.update_from_feed(break_video_feed.new_entries) if break_video_feed.updated?
    else
      break_video_feed = Feedjira::Feed.fetch_and_parse('http://feeds.feedburner.com/BreakVideos')
      BreakVideo.update_from_feed(break_video_feed.entries)
    end
  end
end
