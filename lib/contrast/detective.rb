require 'subtle'
module Contrast

  class Detective
    def initialize(*args)
      @fields = args
    end

    def examine(a, b)
      Hash[fields_that_do_not_match(a, b).map do |key|
        [key, { :actual_value => get_the_value(a, key),
                :expected_value => get_the_value(b, key) }]
      end]
    end

    private

    def fields_that_do_not_match(a, b)
      @fields.select do |field| 
        first = get_the_value(a, field)
        second = get_the_value(b, field)
        the_values_the_do_not_match(first, second)
      end
    end

    def get_the_value(object, field)
      begin
        object[field]
      rescue
        object.send(field)
      end
    end

    def the_values_the_do_not_match(a, b)
      a != b && a.to_s != b.to_s
    end
  end
end
