require_relative 'manufacturer'
require_relative 'instancecounter'

class Train

  attr_accessor :speed, :route, :wagons, :num, :type
  include InstanceCounter
  include Manufacturer

  @@trains = []

  def self.find(num)
    @@trains.each do |train|
     if num == train.num
       puts train
     else
       puts "nil"
     end
    end
  end

  def initialize(num, type)
    @num = num.to_s
    @type = type
    @wagons = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def stop
   self.speed = 0
  end

  def ch_speed(ch_speed)
   self.speed == ch_speed
  end

  def add_wagon(wagon)
   if @speed == 0 && wagon.type == @type
     wagons << wagon
   end
  end

  def del_wagon(wagon)
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
     @current_station.station.del_train
     @next_station.add_train
     @current_station_index += 1
  end

  def back
     @current_station.del_train
     @prev_station.add_train
     @current_station_index -= 1
  end
end
