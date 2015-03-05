class String
  require 'htmlentities'

  def is_probably_a_picture?
    image_extensions = %w(.jpg .png .gif .jpeg .gifv)
    image_extensions.each do |ext|
      return true if ends_with?(ext)
    end
    false
  end

  def remove_html_tags
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    self.gsub(re, '')
  end

  def remove_html_tags!
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    self.gsub!(re, '')
  end

  def to_description
    coder = HTMLEntities.new
    coder.decode(self).remove_html_tags.first(160)
  end

  def to_keywords
    self.gsub('.', '').split(' ')
  end
end
