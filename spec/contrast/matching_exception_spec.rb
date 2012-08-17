require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contrast::MatchingException do
  describe "#to_s" do
    it 'no results: The results did not match, but I cannot tell you why.' do
      [nil, []]. each do |value|
        error = Contrast::MatchingException.new value
        get_message_for(error).must_equal 'The results did not match, but I cannot tell you why.'
      end
    end

    it "results: Run them through awesome print" do
      error = Contrast::MatchingException.new( {:result => nil} )
      error.results.expects(:ai).returns('expected results')
      get_message_for(error).must_equal 'expected results'
    end
  end

  def get_message_for(error)
    begin
      raise error
    rescue Exception => e
      return e.message
    end
  end

end
