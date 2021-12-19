# frozen_string_literal: true

require_relative 'manufacturer'

class Wagon
  include Validation
  include Manufacturer

  validate :type, :format, [cargo][passenger]/i

  attr_reader :type, :number, :places

  def initialize(number, type, places)
    @number = number
    @type = type
    @places = places
    @occupied_places = 0
  end

  def all_take_place
    @occupied_places
  end

  def free_places
    @free_places = @places - @occupied_places
    @free_places
  end

end
