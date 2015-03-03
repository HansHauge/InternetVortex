class WelcomeController < ApplicationController
  def home
    #articles
    chive_articles = ChiveArticle.last(20)
    buzzfeed_articles = BuzzfeedArticle.last(20)
    memebase_articles = MemebaseArticle.last(20)
    r_funny_articles = RedditFunnyArticle.last(20)
    articles = chive_articles.concat(buzzfeed_articles).concat(memebase_articles).concat(r_funny_articles)

    #jokes
    jokes = Joke.last(20)

    listings = articles.concat(jokes).sort { |x,y| x.created_at <=> y.created_at }.reverse

    @listings = listings.paginate(:page => params[:page], :per_page => 20)
  end

  def about
  end
end
