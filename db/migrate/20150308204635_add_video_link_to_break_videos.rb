class AddVideoLinkToBreakVideos < ActiveRecord::Migration
  def change
    add_column :break_videos, :video_link, :string
  end
end
