class Joke < ActiveRecord::Base
  validates_presence_of :title, :content, :source

end
