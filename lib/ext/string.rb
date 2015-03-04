class String
  def is_probably_a_picture?
    image_extensions = %w(.jpg .png .gif .jpeg .gifv)
    image_extensions.each do |ext|
      return true if ends_with?(ext)
    end
    false
  end
end
