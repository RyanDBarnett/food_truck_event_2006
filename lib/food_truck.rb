class FoodTruck
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock item
    @inventory[item] || 0
  end

  def stock(item, quantity)
    @inventory[item] = 0 if !@inventory[item]
    @inventory[item] += quantity
  end

  def potential_revenue
    @inventory.keys do |revenue, item|
      revenue += item.price * @inventory[item].quantity
      revenue
    end
  end
end
