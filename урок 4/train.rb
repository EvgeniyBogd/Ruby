class Train

   attr_accessor :speed, :train_route, :wagons , :type, :num, :current_station

   def initialize(num, type)
    @num = num.to_s
    @type = type
    @wagons = []
    @speed = 0
    @current_station = 0
    @train_route = []
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
         @current_station = @train_route.stations.first
      end

      def next_station
         @train_route.stations[@current_station + 1]
      end

      def prev_station
         if @current_station.positive?
          @train_route.stations[@current_station - 1]
         end
      end

      def forward
         @current_station.station.del_train
         @next_station.add_train
         @current_station += 1
      end

      def back
         @current_station.del_train
         @prev_station.add_train
         @current_station -= 1
      end
end
