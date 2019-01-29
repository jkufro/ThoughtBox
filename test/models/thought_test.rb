require 'test_helper'

class ThoughtTest < ActiveSupport::TestCase
  should allow_value("positive").for(:mood)
  should allow_value("negative").for(:mood)
  should allow_value("neutral").for(:mood)
  should_not allow_value("foo").for(:mood)
  should_not allow_value(1000).for(:mood)
end
