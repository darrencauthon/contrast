Dir[File.dirname(__FILE__) + '/contrast/*.rb'].each {|file| require file }
require 'contrast_with'
require 'contrast_with_set'

module Contrast
end
