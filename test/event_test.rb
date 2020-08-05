require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'
require './lib/event'

class EventTest < Minitest::Test
  def setup
    @event1 = Event.new('South Pearl Street Farmers Market')
  end

  def test_it_exists
    assert_instance_of Event, @event1
  end

  def test_name
    assert_equal 'South Pearl Street Farmers Market', @event1.name
  end
end
