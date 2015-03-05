module ApplicationHelper
  def gifv_sub_webm(str)
    str.ends_with?('.gifv') ? str.gsub('.gifv', '.webm') : str
  end

  def gifv_sub_mp4(str)
    str.ends_with?('.gifv') ? str.gsub('.gifv', '.mp4') : str
  end

  def check_if_active(page_link)
    controller_name = controller.class.name
    return "active" if controller_name.include?(page_link)
  end
end
