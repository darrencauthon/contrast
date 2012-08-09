class Object
  def contrast_with(other, fields)
    detective = Contrast::Detective.new(fields)
    detective.examine(self, other)
  end

  def contrast_with!(other, fields)
    results = self.contrast_with(other, fields)
    if results.any?
      exception = Contrast::MatchingException.new
      exception.results = results
      raise exception
    end
  end
end
