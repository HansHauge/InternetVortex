class JokesController < ApplicationController

  def show
    @joke = Joke.friendly.find(params[:id])
  end

end
