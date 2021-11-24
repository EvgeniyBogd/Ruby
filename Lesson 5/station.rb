require_relative 'instance_counter'

class Station
  attr_reader :trains, :name

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
  register_instance
 end

 def add_train(train)
    trains << train
 end

 def train_type(type)
    trains.select {|train| train.type == type}.size
 end

 def delete_train(train)
    trains.delete(train)
 end

end
