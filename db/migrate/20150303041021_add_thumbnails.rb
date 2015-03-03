class AddThumbnails < ActiveRecord::Migration
  def change
    add_column :buzzfeed_articles, :thumbnail, :string
    add_column :chive_articles, :thumbnail, :string
    add_column :memebase_articles, :thumbnail, :string
  end
end
