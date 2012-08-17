class Object
  def contrast_with(other, fields)
    detective = Contrast::Detective.new(*fields)
    detective.examine(self, other)
  end

  def contrast_with!(other, fields)
    results = self.contrast_with(other, fields)
    raise Contrast::MatchingException.new(results) if results.any?
  end
end
