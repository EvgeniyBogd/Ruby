# frozen_string_literal: true

require_relative 'instance_counter'

class Station

  include Validation
  include InstanceCounter

  validate :name, :format, /[а-яa-z1-9]/

  attr_reader :trains, :name

  @@all_stations = []

  def self.all
    @@all_stations
    puts @@all_stations.to_s
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    validate!
    register_instance
  end



  def each_train(&block)
    trains.each(&block)
  end

  def add_train(train)
    trains << train
  end

  def delete_train(train)
    trains.delete(train)
  end

  def train_type(type)
    trains.select { |train| train.type == type }.size
  end

end
