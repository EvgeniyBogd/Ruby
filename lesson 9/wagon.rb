# frozen_string_literal: true

require_relative 'manufacturer'

class Wagon
  TYPE_WAGON = /[cargo][passenger]/i.freeze

  attr_reader :type, :number, :places

  include Manufacturer

  def initialize(number, type, places)
    @number = number
    @type = type
    @places = places
    @occupied_places = 0
    validate!
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def all_take_place
    @occupied_places
  end

  def free_places
    @free_places = @places - @occupied_places
    @free_places
  end

  protected

  def validate!
    raise 'Incorrect type' if type !~ TYPE_WAGON
  end
end
