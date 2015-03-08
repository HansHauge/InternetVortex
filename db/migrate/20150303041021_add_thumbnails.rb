class AddThumbnails < ActiveRecord::Migration
  def change
    add_column :memebase_articles, :thumbnail, :string
  end
end
