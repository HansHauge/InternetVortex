class CreateBreakVideos < ActiveRecord::Migration
  def change
    create_table :break_videos do |t|
      t.string :title
      t.text :summary
      t.string :guid
      t.string :source
      t.string :thumbnail

      t.timestamps null: false
    end
  end
end
