require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contrast::Detective do
  describe "one method comparison" do
    describe "two objects that match" do
      before do
        @a = [:name].to_object
        @b = [:name].to_object
        @detective = Contrast::Detective.new :name
      end

      it "should return no results" do
        @detective.examine(@a, @b).count.must_equal 0
      end
    end
  end
end

