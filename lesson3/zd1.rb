class Station
	attr_reader :station
		
	def initialize(name_station)
		@station = name_station
		@arrive_train = {}
		@counts = []
		@@cr_station = []
		@@cr_station << @station
				
	end

	def cr_station
	    @@cr_station
	end    	

	def add_train
		@@train[@@num_train] = @@type_train
		if @@curent_station == @@name_station
		  @arrive_train << @@train
	    end
	end	

	def train_on_station
		@arrive_train.each {|train, type| puts train}
    end

    def counts_type
    	@counts << @@type_train
    	pass_type = @counts.select {|type| type == "pass"}.size
    	cargo_type = @counts.select {|type| type == "cargo"}.size

    	puts "pass: #{pass_type}, cargo: #{cargo_type}"   	
 		
 	end
	 

    def del_train(train)
    	@arrive_train.delete(train)
    end
end	

class Route

	def initialize(first_station, last_station)
	  @@first_station = first_station
	  @last_station = last_station
	  @inter_station = []
	  @@route = [@@first_station, @last_station]
	end	

	def add_station(name_station)
		@name_station = name_station
		@inter_station << @name_station 
	end 

	def del_station(name_station)
		@inter_station.delete(@@name_station)
	end
	
	def new_route
	  @@route.insert(-2, @inter_station)
	  train.train_route(self) 
	  puts @@route
	end  	
end

class Train
	attr_accessor :speed
	attr_accessor :num_wag

	def initialize(num_train, type_train, num_wag)
      @@num_train = num_train.to_s
      @@type_train = type_train
      @num_wag = num_wag.to_i
      @speed = 0
      @train_route = []
      @@train = []
      
    end

	def up_speed(up_speed)
		self.speed += up_speed
	end	

    def stop
    	self.speed = 0
    end	

    def add_wag
    	
    	if @speed == 0
    		@num_wag += 1
    	else
    	    puts "AAAaaaaaaaaaaa"
    	end    
    	   	
    end

    def del_wag
    		
    	if @speed == 0 && @num_wag > 1
    		@num_wag -= 1
    	else
    		puts "Hmmmmm"
    	end  
    		
    end

    def train_route
    	@train_route = route.new_route(self)
    	puts @train_route
    end   	

    def get_start
    	@@curent_station = @@first_station
    	puts @@curent_station
    
    end	

    def go
    	@@curent_station = @train_route.each_with_index{|st, index| @@curent_station[index] += 1}
    end	

    def forward
    	@next_station = @train_route.each_with_index{|st, index| @@curent_station[index] += 1}


    end

    def back
      	@prev_station = @train_route.each_with_index{|st, index| @@curent_station[index] -= 1}
    end 

end	