require_relative 'manufacturer'
require_relative 'instance_counter'

class Train

  attr_accessor :speed, :route, :wagons, :number, :type
  include InstanceCounter
  include Manufacturer

  @@trains = []

  def self.find(number)
    @@trains.each do |train|
     if number == train.number
       puts train
     else
       puts "nil"
     end
    end
  end

  def initialize(number, type)
    @number = number.to_s
    @type = type
    @wagons = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def stop
   self.speed = 0
  end

  def change_speed(change_speed)
   self.speed == change_speed
  end

  def add_wagon(wagon)
   if @speed == 0 && wagon.type == @type
     wagons << wagon
   end
  end

  def delete_wagon(wagon)
    if @speed == 0 && wagon.type == @type && wagons.include(wagon)
    wagons.delete(wagon)
    end
  end

  def add_route(route)
    self.route = route
    self.route.stations[0].add_train(self)
    @current_station_index = 0
  end

  def next_station
     @next_station = @train_route.stations[@current_station_index += 1]
  end

  def prev_station
     if @current_station.positive?
      @prev_station = @train_route.stations[@current_station_index -= 1]
     end
  end

  def forward
     @current_station.station.delete_train
     @next_station.add_train
     @current_station_index += 1
  end

  def back
     @current_station.delete_train
     @prev_station.add_train
     @current_station_index -= 1
  end
end
