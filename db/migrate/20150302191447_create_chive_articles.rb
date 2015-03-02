class CreateChiveArticles < ActiveRecord::Migration
  def change
    create_table :chive_articles do |t|
      t.string :title
      t.string :guid
      t.string :source
      t.text :summary
      t.string :categories
      t.string :image

      t.timestamps null: false
    end
  end
end
