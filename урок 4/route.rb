class Route

  attr_accessor :stations

  def initialize(first_station, last_stattion)
     @stations = [first_station, last_stattion]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def del_station(station)
   stations.delete(station)
  end
end
