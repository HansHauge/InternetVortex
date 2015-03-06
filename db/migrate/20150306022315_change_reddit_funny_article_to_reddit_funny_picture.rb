class ChangeRedditFunnyArticleToRedditFunnyPicture < ActiveRecord::Migration
  def up
    rename_table :reddit_funny_articles, :reddit_funny_pictures
  end

  def down
    rename_table :reddit_funny_pictures, :reddit_funny_articles
  end
end
