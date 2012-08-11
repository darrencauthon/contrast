module Contrast
  class Detective
    def initialize(*args)
      @fields = args
    end

    def examine(a, b)
      keys = @fields.select do |field| 
        first = get_the_value(a, field)
        second = get_the_value(b, field)
        the_values_the_do_not_match(first, second)
      end
      result = {}
      keys.each do |key|
        result[key] = nil
      end
      result
    end

    private

    def get_the_value(object, field)
      begin
        object.send(field)
      rescue
        object[field]
      end
    end

    def the_values_the_do_not_match(a, b)
      a != b && a.to_s != b.to_s
    end
  end
end
