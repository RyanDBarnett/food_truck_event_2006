require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'

class FoodTruckTest < Minitest::Test
  def setup
    @truck1 =  FoodTruck.new('Rocky Mountain Pies')
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists
    assert_instance_of FoodTruck, @truck1
  end

  def test_name
    assert_equal 'Rocky Mountain Pies', @truck1.name
  end

  def test_inventory_default
    assert_equal({}, @truck1.inventory)
  end

  def test_check_stock_returns_0_if_none_in_stock
    assert_equal(0, @truck1.check_stock(@item1))
  end

  def test_can_stock_items
    @truck1.stock(@item1, 30)
    assert_equal({@item1 => 30}, @truck1.inventory)
    @truck1.stock(@item1, 25)
    assert_equal({@item1 => 55}, @truck1.inventory)
    @truck1.stock(@item2, 12)
    assert_equal({@item1 => 55, @item2 => 12}, @truck1.inventory)
  end

  def test_check_stock
    @truck1.stock(@item1, 30)
    assert_equal(30, @truck1.check_stock(@item1))
    @truck1.stock(@item2, 12)
    assert_equal(12, @truck1.check_stock(@item2))
  end
end
