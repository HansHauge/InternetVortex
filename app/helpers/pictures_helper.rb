module PicturesHelper
  def gifv_sub_webm(str)
    str.ends_with?('.gifv') ? str.gsub('.gifv', '.webm') : str
  end

  def gifv_sub_mp4(str)
    str.ends_with?('.gifv') ? str.gsub('.gifv', '.mp4') : str
  end

  def imgur_gallery?(str)
    str.match(/imgur.com\/gallery/) || str.match(/imgur.com\/a\//)
  end

  def live_meme?(str)
    str.match(/livememe.com/)
  end

  def img_flip?(str)
    str.match(/imgflip.com/)
  end

  def no_direct_link?(img)
    imgur_gallery?(img) || live_meme?(img) || img_flip?(img)
  end
end
