class Slugvideos < ActiveRecord::Migration
  def change
    add_column :break_videos, :slug, :string
    add_index :break_videos, :slug
  end
end
