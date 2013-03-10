require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "examples" do
  it "should return no results when the objects match" do
    fields = [:first_name, :last_name, :city, :state, :zip]
    example_objects = fields.to_objects {[
      ['a', 'b', 'c', 'd', 'e'],
      ['a', 'b', 'c', 'd', 'e']
    ]}

    first = example_objects[0]
    second = example_objects[1]

    first.contrast_with(second, fields).count.must_equal 0
    second.contrast_with(first, fields).count.must_equal 0
    first.contrast_with!(second, fields)
    second.contrast_with!(first, fields)
  end

  it "should return the fields that do not match" do
    fields = [:first_name, :last_name, :city, :state, :zip]
    example_objects = fields.to_objects {[
      ['a', 'b', 'c', 'd', 'e'],
      ['z', 'b', 'c', 'd', 'e']
    ]}

    first = example_objects[0]
    second = example_objects[1]

    first.contrast_with(second, fields).count.must_equal 1
    second.contrast_with(first, fields).count.must_equal 1

    #this statement will force an exception
    begin
      first.contrast_with!(second, fields)
    rescue
    end
  end

  it "should return all fields if they all are different" do
    fields = [:first_name, :last_name, :city, :state, :zip]
    example_objects = fields.to_objects {[
      ['a', 'b', 'c', 'd', 'e'],
      ['z', 'y', 'x', 'w', 'v']
    ]}

    first = example_objects[0]
    second = example_objects[1]

    first.contrast_with(second, fields).count.must_equal 5
    second.contrast_with(first, fields).count.must_equal 5

    error_hit = false
    begin
      first.contrast_with!(second, fields)
    rescue
      error_hit = true
    end
    error_hit.must_equal true
  end

  it "should compare objects to hashes" do
    fields = [:first_name, :last_name, :city, :state, :zip]
    example_objects = fields.to_objects {[
      ['a', 'b', 'c', 'd', 'e'],
    ]}

    first = example_objects[0]
    second = { :first_name => 'z',
               :last_name => 'b',
               :city => 'c',
               :state => 'd',
               :zip => 'e' }

    first.contrast_with(second, fields).count.must_equal 1
    second.contrast_with(first, fields).count.must_equal 1

    #this statement will force an exception
    begin
      first.contrast_with!(second, fields)
      raise 'It did not cause an exception.'
    rescue
    end
  end

  it "should compare hashes to hashes" do
    fields = [:first_name, :last_name, :city, :state, :zip]
    first = { :first_name => 'a',
              :last_name => 'b',
              :city => 'c',
              :state => 'd',
              :zip => 'e' }
    second = { :first_name => 'z',
               :last_name => 'b',
               :city => 'c',
               :state => 'd',
               :zip => 'e' }

    first.contrast_with(second, fields).count.must_equal 1
    second.contrast_with(first, fields).count.must_equal 1

    #this statement will force an exception
    begin
      first.contrast_with!(second, fields)
      raise 'It did not cause an exception.'
    rescue
    end
  end

  it "should use the keys of the argument if it is a hash" do
    fields = [:first_name, :last_name, :city, :state, :zip]
    first = { :first_name => 'a',
              :last_name => 'b',
              :city => 'c',
              :state => 'd',
              :zip => 'e' }
    second = { :first_name => 'z',
               :last_name => 'b',
               :city => 'c',
               :state => 'd',
               :zip => 'e' }

    first.contrast_with(second).count.must_equal 1
    first.contrast_with({ :first_name => 'a' }).count.must_equal 0
    first.contrast_with({ :last_name => 'b' }).count.must_equal 0
    first.contrast_with({ :last_name => 'c' }).count.must_equal 1
  end
  
end
