module ApplicationHelper

  def article_is_probably_a_video?(article)
    thumbnail_setter = ThumbnailSetter.new({})
    thumbnail_setter.video_thumbnails.include?(article.thumbnail) ? 'embed-responsive embed-responsive-16by9' : 'img-responsive'
  end
end
