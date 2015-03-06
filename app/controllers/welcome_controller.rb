class WelcomeController < ApplicationController
  def home
    time_range = (DateTime.current - 1.day)..DateTime.current
    unsorted_listings = []
    sources = gather_sources(time_range)
    sources.each do |source|
      unsorted_listings.concat(source)
    end

    listings = unsorted_listings.sort { |x,y| x.created_at <=> y.created_at }.reverse
    @listings = listings.paginate(:page => params[:page], :per_page => 30)
  end

  def about
  end

  def archive
    begin
      date = Time.parse(params[:date])
    rescue ArgumentError
      flash[:danger] = 'Invalid Date'
      redirect_to '/'
      return
    end

    time_range = date.at_beginning_of_day..date.at_end_of_day
    unsorted_listings = []
    sources = gather_sources(time_range)
    sources.each do |source|
      unsorted_listings.concat(source)
    end

    listings = unsorted_listings.sort { |x,y| x.created_at <=> y.created_at }.reverse
    @listings = listings.paginate(:page => params[:page], :per_page => 30)
    @archive = true
    @channel = ''

    flash.now[:danger] = 'No content found...' if @listings.count == 0
  end

  private

  def gather_sources(time_range)
    chive_articles = ChiveArticle.where(created_at: time_range)
    buzzfeed_articles = BuzzfeedArticle.where(created_at: time_range)
    memebase_articles = MemebaseArticle.where(created_at: time_range)
    r_funny_pictures = RedditFunnyPicture.where(created_at: time_range)
    jokes = Joke.where(created_at: time_range)

    [chive_articles, buzzfeed_articles, memebase_articles, r_funny_pictures, jokes]
  end
end
