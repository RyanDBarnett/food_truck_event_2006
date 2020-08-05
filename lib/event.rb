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
end
