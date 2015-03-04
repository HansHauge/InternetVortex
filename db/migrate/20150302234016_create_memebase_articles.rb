class CreateMemebaseArticles < ActiveRecord::Migration
  def change
    create_table :memebase_articles do |t|
      t.string :title
      t.string :categories
      t.string :guid
      t.string :source

      t.timestamps null: false
    end
  end
end
