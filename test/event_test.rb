require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'
require './lib/event'

class EventTest < Minitest::Test
  def setup
    @event1 = Event.new('South Pearl Street Farmers Market')
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  def test_it_exists
    assert_instance_of Event, @event1
  end

  def test_name
    assert_equal 'South Pearl Street Farmers Market', @event1.name
  end

  def test_no_food_trucks_by_default
    assert_equal [], @event1.food_trucks
  end

  def test_add_food_truck
    @event1.add_food_truck(@food_truck1)
    assert_equal [@food_truck1], @event1.food_trucks
    @event1.add_food_truck(@food_truck2)
    assert_equal [@food_truck1, @food_truck2], @event1.food_trucks
    @event1.add_food_truck(@food_truck3)
    assert_equal [@food_truck1, @food_truck2, @food_truck3], @event1.food_trucks
  end
end
