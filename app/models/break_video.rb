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
          :thumbnail  => find_or_create_thumbnail(entry),
          :summary    => entry.summary,
          :guid       => entry.entry_id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(entry)
    return entry.image if entry.image.present?

    default_image = '//media1.break.com/break/img/site/nav/brk-logo5.png'
    youtube_image = '//www.youtube.com/yt/brand/media/image/YouTube-logo-full_color.png'
    vine_image = '//vine.co/static/images/vine_glyph_2x.png'

    return youtube_image if entry.summary.match(/youtube.com/)
    if entry.summary.match(/src='/)
      thumb_string = entry.summary.match(/src='/).post_match.match(/'/).pre_match
      thumb_string.include?('vine.co') ? vine_image : thumb_string
    else
      default_image
    end
  end
end
