class Passenger_wagon < Wagon

  attr_reader :places

  def initialize(number, places)
  	super number, :Passenger
    @places = places.to_i
    @occupied_place = 0
  end

  def take_place
    @occupied_place += 1 if @occupied_place < places
  end

  def all_take_place
    @occupied_place
  end

  def free_places
    @free_place = @places - @occupied_place
    @free_place
  end
end
