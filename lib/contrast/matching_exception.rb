require 'awesome_print'
module Contrast
  class MatchingException < StandardError  

    def initialize(results)
      @results = results
    end

    attr_accessor :results

    def to_s
      return 'The results did not match, but I cannot tell you why.' if results.nil? || results.empty?
      return self.results.ai
    end
  end
end
