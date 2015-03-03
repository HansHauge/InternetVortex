class RedditFunnyArticle < ActiveRecord::Base
  attr_accessor :actual_image
   validates_uniqueness_of :guid

  validates_presence_of :title, :source, :guid, :content

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  def actual_image
    image_url = content.match(/">\[link\]/).pre_match.match(/"/).post_match.match(/.*(href=")/).post_match + '.png'
    image_url.match(/imgur.com\/gallery/) ? image_url.gsub('imgur.com/gallery', 'i.imgur.com') : image_url
  end

  private

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create(
          :title     => entry.title,
          :content   => entry.summary,
          :source    => get_host_without_www(entry.url),
          :thumbnail => find_or_create_thumbnail(entry.media_thumbnail_url.first),
          :guid      => entry.id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(url)
    url || actual_image
  end

  def self.get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
