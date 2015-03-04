class BuzzfeedArticle < ActiveRecord::Base
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
          :title     => entry.title,
          :summary   => entry.summary,
          :source    => get_host_without_www(entry.url),
          :thumbnail => find_or_create_thumbnail(entry.media_thumbnail_url.first),
          :guid      => entry.id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(thumb)
    default_image = "//s3-ak.buzzfed.com/static/images/global/buzzfeed-logo.png?v=201502271515"
    thumb || default_image
  end

  def self.get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
