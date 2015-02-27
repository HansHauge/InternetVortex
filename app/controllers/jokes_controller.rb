class JokesController < ApplicationController
  def index
    @jokes = Joke.last(20)
  end
end
