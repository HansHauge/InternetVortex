class MemesPicture < ActiveRecord::Base
  attr_accessor :actual_image

  require 'ext/string'

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_uniqueness_of :guid
  validates_presence_of :title, :source, :guid, :content

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  def actual_image
    thumbnail
  end

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create(
          :title     => entry.title,
          :content   => entry.summary,
          :source    => 'memes.com',
          :thumbnail => find_or_create_thumbnail(entry),
          :guid      => entry.id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(entry)
    finder = ThumbnailSetter.new(entry: entry, default_image: default_image, summary_or_content: entry.summary)
    finder.find_or_create_thumbnail
  end

  def self.default_image
    '//s5.postimg.org/4x46q0m3n/memes_logo.png'
  end
end
