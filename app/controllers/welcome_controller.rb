class WelcomeController < ApplicationController
  def home
    #articles
    chive_articles = ChiveArticle.last(20)
    buzzfeed_articles = BuzzfeedArticle.last(20)
    articles = chive_articles.concat(buzzfeed_articles)

    #jokes
    jokes = Joke.last(20)

    listings = articles.concat(jokes).sort { |x,y| x.created_at <=> y.created_at }

    @listings = listings.paginate(:page => params[:page], :per_page => 20)
  end

  def about
  end
end
