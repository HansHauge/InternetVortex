class MemebaseArticle < ActiveRecord::Base
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
          :categories => entry.categories,
          :source     => get_host_without_www(entry.url),
          :thumbnail  => find_or_create_thumbnail(entry.content),
          :guid       => entry.entry_id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(content)
    thumb_string = content.match(/src='/).post_match.match(/'/).pre_match
    thumb_string.include?('vine.co') ? 'https://vine.co/static/images/vine_glyph_2x.png' : thumb_string
  end

  def self.get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
