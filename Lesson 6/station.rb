require_relative 'instance_counter'

class Station
  attr_reader :trains, :name
  STATION_NAME = /[а-яa-z1-9]/

  include InstanceCounter

  @@all_stations = []

  def self.all
    @@all_stations
    puts "#{@@all_stations}"
  end

 def initialize(name)
 	@name = name
 	@trains = []
  @@all_stations << self
  validate!
  register_instance
 end

 def valid?
   validate!
   true
 rescue
   false
 end

  def add_train(train)
   trains << train
 end

 def delete_train(train)
   trains.delete(train)
 end

 def train_type(type)
    trains.select {|train| train.type == type}.size
 end

 protected

 def validate!
   raise "Incorrect name" if name !~ STATION_NAME
 end

end
