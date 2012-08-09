class Object
  def contrast_with(other, fields)
    detective = Contrast::Detective.new(fields)
    detective.examine(self, other)
  end
end
