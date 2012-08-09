module Contrast
  class Detective
    def initialize(*args)
      @fields = args
    end

    def examine(a, b)
      results = []
      @fields.each do |field|
        results << field if the_values_the_do_not_match(a.send(field), b.send(field))
      end
      results
    end

    private

    def the_values_the_do_not_match(a, b)
      a != b && a.to_s != b.to_s
    end
  end
end
