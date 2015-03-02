class WelcomeController < ApplicationController
  def home
    chive_articles = ChiveArticle.last(20)
    jokes = Joke.last(20)

    @listings = chive_articles.concat(jokes).sort { |x,y| x.created_at <=> y.created_at }
  end
end
