require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "#contrast_with_set" do
  describe "empty set compared with empty set" do
    it "should return no results" do
      result = [].contrast_with_set([], :fields => [:name])
      result.count.must_equal 0
    end
  end
end
