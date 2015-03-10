class BreakVideo < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :source, :guid
  validates_uniqueness_of :guid

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  private

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create(
          :title      => entry.title,
          :source     => 'break.com',
          :thumbnail  => default_image,
          :summary    => entry.summary,
          :guid       => entry.entry_id,
          :video_link => find_or_create_video(entry)
        )
      end
    end
  end

  def self.find_or_create_video(entry)
    parser = VideoParser.new(entry: entry, default_image: default_image, summary_or_content: entry.content)
    parser.find_or_create_video
  end

  def self.default_image
    '//media1.break.com/break/img/site/nav/brk-logo5.png'
  end
end
