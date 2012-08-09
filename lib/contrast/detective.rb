module Contrast
  class Detective
    def initialize(*args)
      @fields = args
    end

    def examine(a, b)
      results = []
      @fields.each do |field|
        first_value = -> { a.send(field) }.call_safely { a[field] }
        second_value = -> { b.send(field) }.call_safely { b[field] }
        results << field if the_values_the_do_not_match(first_value, second_value)
      end
      results
    end

    private

    def the_values_the_do_not_match(a, b)
      a != b && a.to_s != b.to_s
    end
  end
end
