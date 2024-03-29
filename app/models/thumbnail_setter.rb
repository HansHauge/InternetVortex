class ThumbnailSetter
  attr_accessor :entry, :default_image, :summary_or_content

  def initialize(params)
    @entry              = params[:entry]
    @default_image      = params[:default_image]
    @summary_or_content = params[:summary_or_content]
  end

  def find_or_create_thumbnail
    return entry.media_thumbnail_url.first if entry.try(:media_thumbnail_url)
    return entry.image if entry.try(:image)
    return default_image unless summary_or_content
    return youtube_image if summary_or_content.match(/youtube.com/)
    return vimeo_image if summary_or_content.match(/vimeo.com/)
    return liveleak_image if summary_or_content.match(/liveleak.com/)

    thumb_string = ''

    if summary_or_content.match(/src='/)
      thumb_string = summary_or_content.match(/src='/).post_match.match(/'/).pre_match
    elsif summary_or_content.match(/src="/)
      thumb_string = summary_or_content.match(/src="/).post_match.match(/"/).pre_match
    end

    if thumb_string.present?
      thumb_string.include?('vine.co') ? vine_image : thumb_string
    else
      default_image
    end
  end

  def video_thumbnails
    [liveleak_image, vine_image, youtube_image, vimeo_image]
  end

  private

  def liveleak_image
    '//lh3.googleusercontent.com/-oFD6F7P-XIo/AAAAAAAAAAI/AAAAAAAAAB0/e7KxDtrAynI/photo.jpg'
  end

  def vine_image
    '//vine.co/static/images/vine_glyph_2x.png'
  end

  def youtube_image
    '//www.youtube.com/yt/brand/media/image/YouTube-logo-full_color.png'
  end

  def vimeo_image
    '//icons.iconarchive.com/icons/danleech/simple/512/vimeo-icon.png'
  end

end
