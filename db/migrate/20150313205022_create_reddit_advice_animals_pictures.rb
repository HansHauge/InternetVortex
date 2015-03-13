class CreateRedditAdviceAnimalsPictures < ActiveRecord::Migration
  def change
    create_table :reddit_advice_animals_pictures do |t|
      t.string :title
      t.string :guid
      t.text :content
      t.string :thumbnail
      t.string :source
      t.string :slug

      t.timestamps null: false
    end

    add_index :reddit_advice_animals_pictures, :slug
  end
end
