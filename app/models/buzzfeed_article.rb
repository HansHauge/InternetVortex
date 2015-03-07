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
          :source    => 'buzzfeed.com',
          :thumbnail => find_or_create_thumbnail(entry),
          :guid      => entry.id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(entry)
    return entry.media_thumbnail_url.first if entry.try(:media_thumbnail_url)

    default_image = "//s3-ak.buzzfed.com/static/images/global/buzzfeed-logo.png?v=201502271515"
    youtube_image = '//www.youtube.com/yt/brand/media/image/YouTube-logo-full_color.png'

    return default_image unless entry.content

    return youtube_image if entry.content.match(/youtube.com/)
    if entry.content.match(/src='/)
      thumb_string = entry.content.match(/src='/).post_match.match(/'/).pre_match
      thumb_string.include?('vine.co') ? '//vine.co/static/images/vine_glyph_2x.png' : thumb_string
    else
      default_image
    end
  end
end
