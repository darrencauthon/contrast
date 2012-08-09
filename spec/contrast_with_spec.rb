require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'contrast with' do
  it "should pass the arguments to the contrast detective" do
    fields = [:city, :state]
    first = fields.to_object
    second = fields.to_object
    expected_value = Object.new
    Contrast::Detective.any_instance.expects(:examine).
      with(first, second).returns(expected_value)

    result = first.contrast_with(second, fields)

    result.must_be_same_as expected_value
  end
end

describe 'contrast with!' do
  it "should pass the arguments to the contrast detective" do
    fields = [:city, :state]
    first = fields.to_object
    second = fields.to_object
    expected_value = []
    Contrast::Detective.any_instance.expects(:examine).
      with(first, second).returns(expected_value)

    first.contrast_with!(second, fields)
  end
  it "should throw an exception if any results are returned" do
    fields = [:city, :state]
    first = fields.to_object
    second = fields.to_object
    result = [:city]
    Contrast::Detective.any_instance.expects(:examine).
      with(first, second).returns(result)

    exception_thrown = -> { first.contrast_with!(second, fields) }.
      call_safely { true }

    exception_thrown.must_equal true
  end

  it "should not throw an exception if no results are thrown" do
    fields = [:city, :state]
    first = fields.to_object
    second = fields.to_object
    result = []
    Contrast::Detective.any_instance.expects(:examine).
      with(first, second).returns(result)

    exception_thrown = -> { first.contrast_with!(second, fields); false }.
      call_safely { true }

    exception_thrown.must_equal false
  end

  it "should return a contrast exception" do
    fields = [:city, :state]
    first = fields.to_object
    second = fields.to_object
    result = [:city]
    Contrast::Detective.any_instance.expects(:examine).
      with(first, second).returns(result)

    exception_thrown = false
    begin
      first.contrast_with!(second, fields)
    rescue Contrast::MatchingException
      exception_thrown = true
    end

    exception_thrown.must_equal true
  end

  it "should return the contrast results in the exception" do
    fields = [:city, :state]
    first = fields.to_object
    second = fields.to_object
    result = [:city]
    Contrast::Detective.any_instance.expects(:examine).
      with(first, second).returns(result)

    begin
      first.contrast_with!(second, fields)
    rescue Contrast::MatchingException => e
      e.results.must_be_same_as(result)
    end
  end
end
