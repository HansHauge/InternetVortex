class CreateRedditFunnyArticles < ActiveRecord::Migration
  def change
    create_table :reddit_funny_articles do |t|
      t.string :title
      t.string :source
      t.string :guid
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
