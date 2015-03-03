class RedditFunnyArticle < ActiveRecord::Base
  attr_accessor :actual_image

  validates_presence_of :title, :source, :guid, :content

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  def actual_image
    content.match(/">\[link\]/).pre_match.match(/"/).post_match.match(/<a href="/).post_match
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
          :thumbnail => extract_thumbnail(entry.summary),
          :guid      => entry.id
        )
      end
    end
  end

  def self.extract_thumbnail(summary)
    if summary.match(/<img src=/)
      summary.match(/<img src="/).post_match.match(/"/).pre_match
    # elsif summary.match(/i.imgur.com/)
    #   '//i.imgur.com' << summary.match(/\/\/i.imgur.com/).post_match.match(/"/).pre_match
    else
      ""
    end
  end

  def self.get_host_without_www(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    host = URI.parse(url).host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end
end
