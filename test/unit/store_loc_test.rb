require 'test_helper'

class StoreLocTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert StoreLoc.new.valid?
  end
end
