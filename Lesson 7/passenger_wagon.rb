class Passenger_wagon < Wagon

  def initialize(number, places)
  	super number, :Passenger, places.to_i
  end

  def take_place
    @occupied_places += 1 if @occupied_places < places
  end

end
