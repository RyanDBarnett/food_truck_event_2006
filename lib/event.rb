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
end
