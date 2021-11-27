require_relative 'instance_counter'

class Route

  attr_accessor :stations

  include InstanceCounter

  def initialize(first_station, last_stattion)
     @stations = [first_station, last_stattion]
     register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
   stations.delete(station)
  end


end
