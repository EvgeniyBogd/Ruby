# frozen_string_literal: true

require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Train
  extend Accessors
  include Validation
  include InstanceCounter
  include Manufacturer

  TRAIN_NUMBER = /^[а-яa-z0-9]{3}?-?[а-яa-z0-9]{2}$/i.freeze
  TRAIN_TYPE = /[cargo][passenger]/i.freeze

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER
  validate :type, :format, TRAIN_TYPE

  attr_accessor :speed, :route, :wagons, :number, :type

  @@trains = []

  def self.find(number)
    @@trains.each { |train| train.number == number }
  end

  def initialize(number, type)
    @number = number.to_s
    @type = type
    @wagons = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def each_wagon(&block)
    wagons.each(&block)
  end

  def stop
    self.speed = 0
  end

  def change_speed(change_speed)
    speed == change_speed
  end

  def add_wagon(wagon)
    wagons << wagon if @speed.zero? && wagon.type == @type
  end

  def delete_wagon(wagon)
    wagons.delete(wagon) if @speed.zero? && wagon.type == @type && wagons.include(wagon)
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
    @prev_station = @train_route.stations[@current_station_index -= 1] if @current_station.positive?
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
