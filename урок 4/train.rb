class Train

   attr_accessor :speed, :train_route, :wagons , :type, :num, :current_stations

   def initialize(num, type)
    @num = num.to_s
    @type = type
    @wagons = []
    @speed = 0
    @current_stations = 0
   end

   def stop
     self.speed = 0
   end

   def ch_speed(ch_speed)
     self.speed == ch_speed
   end

   def add_wagon(wagon)

       if @speed == 0 && wagon.type == @type
         wagons << wagon
       end
   end

      def del_wagon(wagon)
        if @speed == 0 && wagon.type == @type && wagons.include(wagon)
        wagons.delete(wagon)
        end
      end

      def add_route(route)
         @train_route = route
         @current_stations == @first_station
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
