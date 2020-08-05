class Event
  attr_reader :name, :food_trucks
  def initialize name
    @name = name
    @food_trucks = []
  end

  def add_food_truck truck
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map(&:name)
  end

  def food_trucks_that_sell item
    @food_trucks.select do |truck|
      truck.check_stock(item) > 0
    end
  end

  def sorted_item_list
    @food_trucks.reduce([]) do |list, truck|
      item_names = truck.inventory.keys.map(&:name)
      list.concat(item_names)
    end.sort.uniq
  end

  def total_inventory
    @food_trucks.reduce({}) do |inventory, truck|
      truck.inventory.keys.each do |item|
        inventory[item] = {quantity: 0, food_trucks: []} if !inventory[item]
        inventory[item][:food_trucks] << truck if !inventory[item][:food_trucks].include?(truck)
        inventory[item][:quantity] += truck.inventory[item]
      end
      inventory
    end
  end

  def overstocked_items
    total_inventory.keys.reduce([]) do |overstocked_items, item|
      if total_inventory[item][:quantity] > 50 && total_inventory[item][:food_trucks].length > 1
        overstocked_items << item
      end
      overstocked_items
    end
  end

  def sell(item, quantity)
    if total_inventory[item][:quantity] > quantity
      total_inventory[item][:food_trucks].each do |truck|
        if truck.inventory[item] > quantity
          truck.inventory[item] -= quantity
          quantity = 0
        else
          quantity -= truck.inventory[item]
          truck.inventory[item] = 0
        end
      end
      true
    else
      false
    end
  end
end
