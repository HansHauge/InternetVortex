class RedditFunnyArticle < ActiveRecord::Base
  attr_accessor :actual_image

  require 'ext/string'

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_uniqueness_of :guid
  validates_presence_of :title, :source, :guid, :content

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  def self.actual_image(summary)
    image_url = summary.match(/">\[link\]/).pre_match.match(/"/).post_match.match(/.*(href=")/).post_match
    image_url_with_extension = image_url.is_probably_a_picture? ? image_url : image_url + '.png'
    image_url_with_extension.match(/imgur.com\/gallery/) ? image_url_with_extension.gsub('imgur.com/gallery', 'i.imgur.com') : image_url_with_extension
  end

  def actual_image
    image_url = content.match(/">\[link\]/).pre_match.match(/"/).post_match.match(/.*(href=")/).post_match
    image_url_with_extension = image_url.is_probably_a_picture? ? image_url : image_url + '.png'
    image_url_with_extension.match(/imgur.com\/gallery/) ? image_url_with_extension.gsub('imgur.com/gallery', 'i.imgur.com') : image_url_with_extension
  end

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create(
          :title     => entry.title,
          :content   => entry.summary,
          :source    => get_host_without_www(entry.url),
          :thumbnail => find_or_create_thumbnail(entry.media_thumbnail_url.first, entry.summary),
          :guid      => entry.id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(url, summary)
    url || actual_image(summary)
  end

  def self.get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
