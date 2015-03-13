class CreateMemesPictures < ActiveRecord::Migration
  def change
    create_table :memes_pictures do |t|
      t.string :title
      t.text :content
      t.string :guid
      t.string :thumbnail
      t.string :source
      t.string :slug

      t.timestamps null: false
    end

    add_index :memes_pictures, :slug
  end
end
