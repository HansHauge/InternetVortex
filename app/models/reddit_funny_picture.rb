class RedditFunnyPicture < ActiveRecord::Base
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
    image_url = content.match(/">\[link\]/).pre_match.match(/"/).post_match.match(/.*(href=")/).post_match
    if from_imgur?(image_url) && !imgur_gallery?(image_url) && !image_url.is_probably_a_picture?
      image_url + '.png'
    else
      image_url
    end
  end

  def from_imgur?(string)
    string.match(/imgur.com/)
  end

  def imgur_gallery?(string)
    string.match(/imgur.com\/gallery/)
  end

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create(
          :title     => entry.title,
          :content   => entry.summary,
          :source    => 'reddit.com/r/funny',
          :thumbnail => find_or_create_thumbnail(entry),
          :guid      => entry.id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(entry)
    finder = ThumbnailSetter.new(entry: entry, default_image: default_image)
    finder.find_or_create_thumbnail
  end

  def self.default_image
    '//c.thumbs.redditmedia.com/UNcO-h_QcS9PD-Gn.jpg'
  end
end













