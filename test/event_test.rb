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

  def test_food_truck_names
    @event1.add_food_truck(@food_truck1)
    @event1.add_food_truck(@food_truck2)
    @event1.add_food_truck(@food_truck3)
    assert_equal ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @event1.food_truck_names
  end

  def test_food_trucks_that_sell
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @event1.add_food_truck(@food_truck1)
    @event1.add_food_truck(@food_truck2)
    @event1.add_food_truck(@food_truck3)

    assert_equal [@food_truck1, @food_truck3], @event1.food_trucks_that_sell(@item1)
    assert_equal [@food_truck2], @event1.food_trucks_that_sell(@item4)
  end

  def test_sorted_item_list
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @event1.add_food_truck(@food_truck1)
    @event1.add_food_truck(@food_truck2)
    @event1.add_food_truck(@food_truck3)

    expected = [@item2.name, @item4.name, @item1.name, @item3.name]
    assert_equal expected, @event1.sorted_item_list
  end

  def test_total_inventory
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @event1.add_food_truck(@food_truck1)
    @event1.add_food_truck(@food_truck2)
    @event1.add_food_truck(@food_truck3)

    expected = {
      @item2 => {
        quantity: 7,
        food_trucks: [@food_truck1]
      },
      @item4 => {
        quantity: 50,
        food_trucks: [@food_truck2]
      },
      @item1 => {
        quantity: 100,
        food_trucks: [@food_truck1, @food_truck3]
      },
      @item3 => {
        quantity: 25,
        food_trucks: [@food_truck2]
      }
    }

    assert_equal expected, @event1.total_inventory
  end

  def test_overstocked_items
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @event1.add_food_truck(@food_truck1)
    @event1.add_food_truck(@food_truck2)
    @event1.add_food_truck(@food_truck3)

    expected = [@item1]

    assert_equal expected, @event1.overstocked_items
  end
end
