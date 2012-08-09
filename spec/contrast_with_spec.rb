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
