class CreateCrackedArticles < ActiveRecord::Migration
  def change
    create_table :cracked_articles do |t|
      t.string :title
      t.text :summary
      t.string :source
      t.string :guid
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
