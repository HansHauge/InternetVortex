class VideoParser
  attr_accessor :entry, :default_image, :summary_or_content

  def initialize(params)
    @entry              = params[:entry]
    @default_image      = params[:default_image]
    @summary_or_content = params[:summary_or_content]
  end

  def find_or_create_video
    return entry.image if entry.try(:image)
    return default_image unless summary_or_content
    return youtube_image if summary_or_content.match(/youtube.com/)

    video_string = ''

    if summary_or_content.match(/src='/)
      video_string = summary_or_content.match(/src='/).post_match.match(/'/).pre_match
    elsif summary_or_content.match(/src="/)
      video_string = summary_or_content.match(/src="/).post_match.match(/"/).pre_match
    end

    if video_string.present?
      video_string.include?('vine.co') ? vine_image : video_string
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
