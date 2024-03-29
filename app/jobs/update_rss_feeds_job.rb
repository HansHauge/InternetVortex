class UpdateRssFeedsJob < ActiveJob::Base
  attr_accessor  :r_jokes_feed,
                 :memebase_feed,
                 :r_funny_pictures_feed,
                 :break_video_feed,
                 :xkcd_comic_feed,
                 :failblog_feed,
                 :memes_pictures_feed,
                 :r_advice_animals_pictures_feed

  queue_as :default

  def perform
    update_r_jokes
    update_memebase_articles
    update_r_funny_pictures
    update_memes_pictures
    update_r_advice_animals_feed
    update_break_videos
    update_xkcd_comics
    update_failblog_articles
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

  def update_failblog_articles
    if failblog_feed
      failblog_feed = Feedjira::Feed.update(failblog_feed)
      FailblogArticle.update_from_feed(failblog_feed.new_entries) if failblog_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      failblog_feed = Feedjira::Feed.fetch_and_parse('http://feeds.feedburner.com/failblog')
      FailblogArticle.update_from_feed(failblog_feed.entries)
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

  def update_memes_pictures
    if memes_pictures_feed
      memes_pictures_feed = Feedjira::Feed.update(memes_pictures_feed)
      MemesPicture.update_from_feed(memes_pictures_feed.new_entries) if memes_pictures_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      memes_pictures_feed = Feedjira::Feed.fetch_and_parse('http://www.memes.com/rss.xml')
      MemesPicture.update_from_feed(memes_pictures_feed.entries)
    end
  end

  def update_r_advice_animals_feed
    if r_advice_animals_pictures_feed
      r_advice_animals_pictures_feed = Feedjira::Feed.update(r_advice_animals_pictures_feed)
      RedditAdviceAnimalsPicture.update_from_feed(r_advice_animals_pictures_feed.new_entries) if r_advice_animals_pictures_feed.updated?
    else
      Feedjira::Feed.add_common_feed_entry_elements("media", :value => :url,    :as => :media)
      r_advice_animals_pictures_feed = Feedjira::Feed.fetch_and_parse('http://www.reddit.com/r/AdviceAnimals/.rss')
      RedditAdviceAnimalsPicture.update_from_feed(r_advice_animals_pictures_feed.entries)
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

  def update_xkcd_comics
    if xkcd_comic_feed
      xkcd_comic_feed = Feedjira::Feed.update(xkcd_comic_feed)
      XkcdComic.update_from_feed(xkcd_comic_feed.new_entries) if xkcd_comic_feed.updated?
    else
      xkcd_comic_feed = Feedjira::Feed.fetch_and_parse('http://xkcd.com/rss.xml')
      XkcdComic.update_from_feed(xkcd_comic_feed.entries)
    end
  end
end
