class AddSourceToXkcdComics < ActiveRecord::Migration
  def change
    add_column :xkcd_comics, :source, :string
  end
end
