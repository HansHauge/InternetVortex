class ChiveArticle < ActiveRecord::Base
  validates_presence_of :title, :summary, :source, :guid, :image
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
          :summary    => entry.summary,
          :source     => get_host_without_www(entry.url),
          :guid       => entry.url,
          :thumbnail  => entry.media_thumbnail_url.first,
          :categories => entry.categories,
          :image      => entry.image
        )
      end
    end
  end

  def self.get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
