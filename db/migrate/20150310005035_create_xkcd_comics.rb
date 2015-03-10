class CreateXkcdComics < ActiveRecord::Migration
  def change
    create_table :xkcd_comics do |t|
      t.string :title
      t.text :content
      t.string :thumbnail
      t.string :guid

      t.timestamps null: false
    end

    add_column :xkcd_comics, :slug, :string
    add_index :xkcd_comics, :slug
  end
end
