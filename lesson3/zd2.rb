class Station
  attr_reader :trains, :name

 def initialize(name)
 	@name = name
 	@trains = []
 end
 
 def add_train(train)
    trains << train
 end 

 def train_type(type)
    @trains.select {|train| train.type == type}.size
 end

 def del_train(train)
    trains.delete(train)
 end   	
 
end	

class Route

  attr_accessor :stations

  def initialize(first_station, last_stattion)
   @first_station = first_station
   @last_stattion = last_stattion
   @stations = [@first_station, @last_stattion]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def del_station(station)
   @stations.delete(station)
  end  

  

end   

class Train
   
   attr_accessor :speed, :train_route, :wag
   
 
   def initialize(num, type, wag)
    @num = num.to_s
    @type = type
    @wag = wag.to_i
    @speed = 0
    @current_stations = 0
   end
   
   def stop
     self.speed = 0
   end
   
   def ch_speed(ch_speed)
     self.speed == ch_speed   
   end  

   def add_wag
       if @speed == 0
         @wag += 1
     end 
   end
      
      def del_wag
      if @speed == 0 && @wag > 1
      @wag -= 1   
      end   
      end

      def add_route(route)
         @train_route = route
         @train_route.stations[@current_stations]
      end   
            
      def next_station
         @train_route.stations[@current_stations + 1]
      end

      def prev_station
         if @current_stations.positive?
          @train_route.stations[@current_stations - 1]
         end
      end
      
      def forward
         @current_stations.station.del_train
         @next_station.add_train
         @current_stations += 1
      end

      def back
         @current_stations.del_train
         @prev_station.add_train
         @current_stations -= 1
      end 
end