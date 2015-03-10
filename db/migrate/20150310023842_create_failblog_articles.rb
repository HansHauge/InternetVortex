class CreateFailblogArticles < ActiveRecord::Migration
  def change
    create_table :failblog_articles do |t|
      t.string :guid
      t.string :categories
      t.string :title
      t.text :summary
      t.string :thumbnail
      t.string :source
      t.string :slug

      t.timestamps null: false
    end

    add_index :failblog_articles, :slug
  end
end
