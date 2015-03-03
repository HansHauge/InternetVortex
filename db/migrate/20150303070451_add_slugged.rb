class AddSlugged < ActiveRecord::Migration
  def change
    add_column :reddit_funny_articles, :slug, :string
    add_index :reddit_funny_articles, :slug
  end
end
