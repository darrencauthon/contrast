require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contrast::Detective do
  describe "one method comparison" do
    describe "two objects that match" do
      before do
        @a = [:name].to_object
        @b = [:name].to_object
        @a.name = ""
        @b.name = ""
        detective = Contrast::Detective.new :name
        @result = detective.examine(@a, @b)
      end

      it "should return no results" do
        @result.count.must_equal 0
      end
    end

    describe "two objects that do not match" do
      before do
        @a = [:name].to_object
        @b = [:name].to_object
        @a.name = 'apple'
        @b.name = 'orange'
        detective = Contrast::Detective.new :name
        @result = detective.examine(@a, @b)
      end

      it "should return one result" do
        @result.count.must_equal 1
      end

      it "should return the field" do
        @result[0].must_equal :name
      end
    end
  end

  describe "two methods comparison" do
    describe "two objects that match" do
      before do
        @a = [:first_name, :last_name].to_object
        @b = [:first_name, :last_name].to_object
        objects = [:first_name, :last_name].to_objects {[
          ['a', 'b'], ['a', 'b']
        ]}

        detective = Contrast::Detective.new :first_name, :last_name
        @result = detective.examine(objects[0], objects[1])
      end

      it "should return no results" do
        @result.count.must_equal 0
      end
    end

    describe "two objects that do not match by first property" do
      before do
        @a = [:first_name, :last_name].to_object
        @b = [:first_name, :last_name].to_object
        objects = [:first_name, :last_name].to_objects {[
          ['a', 'b'], ['z', 'b']
        ]}
        detective = Contrast::Detective.new :first_name, :last_name
        @result = detective.examine(objects[0], objects[1])
      end

      it "should return one result" do
        @result.count.must_equal 1
      end

      it "should return the field" do
        @result[0].must_equal :first_name
      end
    end

    describe "two objects that do not match by second property" do
      before do
        @a = [:first_name, :last_name].to_object
        @b = [:first_name, :last_name].to_object
        objects = [:first_name, :last_name].to_objects {[
          ['a', 'b'], ['a', 'c']
        ]}
        detective = Contrast::Detective.new :first_name, :last_name
        @result = detective.examine(objects[0], objects[1])
      end

      it "should return one result" do
        @result.count.must_equal 1
      end

      it "should return the field" do
        @result[0].must_equal :last_name
      end
    end

    describe "two objects that do not match by both properties" do
      before do
        @a = [:first_name, :last_name].to_object
        @b = [:first_name, :last_name].to_object
        objects = [:first_name, :last_name].to_objects {[
          ['a', 'b'], ['y', 'z']
        ]}
        detective = Contrast::Detective.new :first_name, :last_name
        @result = detective.examine(objects[0], objects[1])
      end

      it "should return one result" do
        @result.count.must_equal 2
      end

      it "should return the fields" do
        @result[0].must_equal :first_name
        @result[1].must_equal :last_name
      end
    end

    describe 'strange matching' do
      before do
        @a = [:value].to_object
        @b = [:value].to_object
        @detective = Contrast::Detective.new :value
      end

      it "should match integers to strings" do
        @a.value = 1; @b.value = '1'
        @detective.examine(@a, @b).count.must_equal 0
        @detective.examine(@b, @a).count.must_equal 0
      end

      it "should match floats to integers" do
        @a.value = 1; @b.value = 1.0 
        @detective.examine(@a, @b).count.must_equal 0
        @detective.examine(@b, @a).count.must_equal 0
      end
    end

    describe 'matching objects to hashes' do
      before do
        @a = [:value].to_object
        @b = {}
        @detective = Contrast::Detective.new :value
      end

      it "should match the two" do
        @a.value = 1; @b[:value] = 1
        @detective.examine(@a, @b).count.must_equal 0
        @detective.examine(@b, @a).count.must_equal 0
      end
    end
  end
end

