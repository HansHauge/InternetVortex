class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.text :title
      t.text :content
      t.string :source

      t.timestamps
    end
  end
end
