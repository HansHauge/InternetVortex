class JokesController < ApplicationController

  def index
    # Rails.cache.fetch('jokes_index', expires_in: 5.minutes) do
      @jokes = Joke.last(20).paginate(:page => params[:page], :per_page => 20)
    # end
  end

  def show
    @joke = Joke.friendly.find(params[:id])
  end

  def archive
    begin
      date = Time.parse(params[:date])
    rescue ArgumentError
      flash[:danger] = 'Invalid Date'
      redirect_to '/jokes'
      return
    end

    time_range = date.at_beginning_of_day..date.at_end_of_day

    @jokes = Joke.where(created_at: time_range).paginate(:page => params[:page], :per_page => 20)
    @date_message = @jokes.count > 0 ? "Select Date: " : "Try another date:"

    flash.now[:warning] = 'No content found...' if @jokes.count == 0
  end
end
