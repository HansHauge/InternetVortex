class CreateBuzzfeedArticles < ActiveRecord::Migration
  def change
    create_table :buzzfeed_articles do |t|
      t.string :title
      t.text :summary
      t.string :source
      t.string :guid

      t.timestamps null: false
    end
  end
end
