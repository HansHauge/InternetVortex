class WelcomeController < ApplicationController
  def home
    time_range = (DateTime.current - 1.day)..DateTime.current

    chive_articles = ChiveArticle.where(created_at: time_range)
    buzzfeed_articles = BuzzfeedArticle.where(created_at: time_range)
    memebase_articles = MemebaseArticle.where(created_at: time_range)
    r_funny_articles = RedditFunnyArticle.where(created_at: time_range)
    articles = chive_articles.concat(buzzfeed_articles).concat(memebase_articles).concat(r_funny_articles)

    #jokes
    jokes = Joke.where(created_at: time_range)

    listings = articles.concat(jokes).sort { |x,y| x.created_at <=> y.created_at }.reverse

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

    chive_articles = ChiveArticle.where(created_at: time_range)
    buzzfeed_articles = BuzzfeedArticle.where(created_at: time_range)
    memebase_articles = MemebaseArticle.where(created_at: time_range)
    r_funny_articles = RedditFunnyArticle.where(created_at: time_range)

    articles = chive_articles.concat(buzzfeed_articles).concat(memebase_articles).concat(r_funny_articles)

    jokes = Joke.where(created_at: time_range)
    listings = articles.concat(jokes).sort { |x,y| x.created_at <=> y.created_at }.reverse

    @listings = listings.paginate(:page => params[:page], :per_page => 30)
    @archive = true
    @channel = ''

    flash.now[:warning] = 'No content found...' if @listings.count == 0
  end
end
