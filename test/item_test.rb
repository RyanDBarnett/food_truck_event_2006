pry(main)> require './lib/item'
#=> true

pry(main)> item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
#=> #<Item:0x007f9c56740d48...>

pry(main)> item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
#=> #<Item:0x007f9c565c0ce8...>

pry(main)> item2.name
#=> "Apple Pie (Slice)"

pry(main)> item2.price
#=> 2.50

require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists
    assert_instance_of Item, @item1
    assert_instance_of Item, @item2
  end

  def test_name
    assert_equal 'Peach Pie (Slice)', @item1.name
    assert_equal 'Apple Pie (Slice)', @item2.name
  end

  def test_price
    assert_equal 3.75, @item1.price
    assert_equal 2.50, @item2.price
  end
end
