class Station
  attr_reader :trains, :name

 def initialize(name)
 	@name = name.to_s
 	@trains = []
 end

 def add_train(train)
    trains << train.to_s
 end

 def train_type(type)
    @trains.select {|train| train.type == type}.size
 end

 def del_train(train)
    trains.delete(train)
 end

end
