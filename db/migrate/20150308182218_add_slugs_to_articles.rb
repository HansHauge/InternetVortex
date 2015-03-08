class AddSlugsToArticles < ActiveRecord::Migration
  def change
    add_column :memebase_articles, :slug, :string
    add_index :memebase_articles, :slug
  end
end
