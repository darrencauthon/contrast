module Contrast
  class Detective
    def initialize(*args)
      @fields = args
    end

    def examine(a, b)
      results = []
      @fields.each do |field|
        results << field if a.send(field) != b.send(field)
      end
      results
    end
  end
end
