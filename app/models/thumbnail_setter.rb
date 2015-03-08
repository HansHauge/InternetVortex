class ThumbnailSetter
  attr_accessor :entry, :default_image

  def initialize(params)
    @entry         = params[:entry]
    @default_image = params[:default_image]
  end

  def find_or_create_thumbnail
    return entry.media_thumbnail_url.first if entry.try(:media_thumbnail_url)
    return entry.image if entry.try(:image)
    return default_image unless entry.content
    return youtube_image if entry.content.match(/youtube.com/)

    if entry.content.match(/src='/)
      thumb_string = entry.content.match(/src='/).post_match.match(/'/).pre_match
      thumb_string.include?('vine.co') ? vine_image : thumb_string
    else
      default_image
    end
  end

  private

  def vine_image
    '//vine.co/static/images/vine_glyph_2x.png'
  end

  def youtube_image
    '//www.youtube.com/yt/brand/media/image/YouTube-logo-full_color.png'
  end

end
