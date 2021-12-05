# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(number, places)
    super number, :Cargo, places.to_f
  end

  def reduse_volume(occupied_place)
    @occupied_places += occupied_place.to_f if @occupied_places + occupied_place.to_f < places
  end
end
