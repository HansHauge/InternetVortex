class AddContentToRedditFunnyArticles < ActiveRecord::Migration
  def change
    add_column :reddit_funny_articles, :content, :text
  end
end
