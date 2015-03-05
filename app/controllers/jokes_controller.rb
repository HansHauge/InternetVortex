class JokesController < ApplicationController

  def index
    # Rails.cache.fetch('jokes_index', expires_in: 5.minutes) do
      @jokes = Joke.last(20).paginate(:page => params[:page], :per_page => 20)
    # end
  end

  def show
    @joke = Joke.friendly.find(params[:id])
  end
end
