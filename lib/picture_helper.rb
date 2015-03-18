class PictureHelper
  def self.no_direct_link?(img)
    imgur_gallery?(img) || live_meme?(img) || img_flip?(img)
  end

  def self.imgur_gallery?(str)
    str.match(/imgur.com\/gallery/) || str.match(/imgur.com\/a\//)
  end

  def self.live_meme?(str)
    str.match(/livememe.com/)
  end

  def self.img_flip?(str)
    str.match(/imgflip.com/)
  end
end
