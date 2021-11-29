
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Main
  MENU =
  "
  1. Создать станцию
  2. Создать поезд
  3. Создать маршрут
  4. Изменить маршрут
  5. Назначить поезду маршрут
  6. Создать вагон
  7. Изменить количество вагонов
  8. Переместить поезд по маршруту
  9. Посмотреть список станций
  10. Посмотреть список поездов
  11. Посмотреть список вагонов у поезда
  12. Посмотреть список поездов на станции
  13. Занять место в пассажирском вагоне
  14. Занять местов грузовом вагоне"

  attr_accessor :trains,
                :stations,
                :routes,
                :wagons


  def initialize
    @trains = []
    @routes = []
    @stations = []
    @wagons = []
  end

  def menu
    loop do
    puts MENU
    answer = gets.chomp.to_i
      case answer
        when 1
          create_station
        when 2
          create_train
        when 3
          create_route
        when 4
          change_route
        when 5
          train_route
        when 6
          create_wagon
        when 7
          change_wagons
        when 8
          move_train
        when 9
          stations_list
        when 10
          trains_list
        when 11
          train_wagons
        when 12
          station_trains
        when 13
          take_place
        when 14
          reduse_volume
      end
     break if answer == 0
   end
  end

  protected

  def create_station
    puts "Введите название станции"
    name_station = gets.chomp.to_s
    stations << Station.new(name_station)
    puts "Создана станция #{name_station}"
  rescue StandardError => e
    puts "#{e.message}"
  end

  def create_train
    puts "Выберите тип поезда который хотите создать:
    1. Пассажирский
    2. Грузовой"
    type_train = gets.chomp.to_i
    case type_train
      when 1
        puts "Введите номер пассажирского поезда в формате: aaa-aa,111-11,a1a-1a."
        number_train = gets.chomp.to_s
        trains << Passenger_train.new(number_train)
        puts "Создан пассажирский поезд #{number_train}"

      when 2
        puts "Введите номер грузового поезда в формате: aaa-aa,111-11,a1a-1a."
        number_train = gets.chomp.to_s
        trains << Cargo_train.new(number_train)
        puts "Создан грузовой поезд #{number_train}"
    end
  rescue StandardError => e
    puts "#{e.message}"
  end

  def create_route
    puts "Введите название маршрута"
    route_name = gets.chomp.to_s
    puts "Выберите начальную станцию"
    stations.each_with_index{|station, index| puts "#{station.name}: #{index}"}
    first_station_index = gets.chomp.to_i
    first_station = stations[first_station_index]
    puts "#{first_station}"
    puts "Выберите конечную станцию"
    stations.each_with_index{|station, index| puts "#{station.name}: #{index}"}
    last_station_index = gets.chomp.to_i
    last_station = stations[last_station_index]
    puts "#{last_station}"
    route = Route.new(first_station, last_station)
    routes << route
  end

  def change_route
    puts "Выбери номер маршрута, который нужно изменить"
    routes.each_with_index {|name, index| puts "#{name}: #{index}"}
    route_index = gets.chomp.to_i
    puts "Выбран маршрут #{routes[route_index]}"
    puts "1. Добавить станцию"
    puts "2. Удалить станцию"
    choice_routes = gets.chomp.to_i
          case choice_routes
            when 1
              puts "Выберите станцию которую хотите добавить"
              stations.each_with_index{|station, index| puts "#{station.name}: #{index}"}
              station = gets.chomp.to_i
              routes[route_index].add_station(station)
            when 2
              puts "Введите станцию которую хотите удалить"
              station = gets.chomp.to_s
              routes[route_index].delete_station(station)
          end
  end

  def train_route
    puts "Выбери поезд, которому назначиить маршрут"
    trains.each_with_index {|train, index| puts "#{train.number} - #{train.type}: #{index}"}
    train_index = gets.chomp.to_i
    puts "Выбран поезд #{trains[train_index]}"
    puts "Выбери номер маршрута"
    routes.each_with_index {|name, index| puts "#{name}: #{index}"}
    route_index = gets.chomp.to_i
    puts "Выбран маршрут #{routes[route_index]}"
    trains[train_index].add_route(routes[route_index])
    puts "Поезду #{trains[train_index]} присвоен маршрут #{routes[route_index]}"
  end

  def create_wagon
    puts "Выбери тип вагона который хочешь создать"
    puts "1. Пассажирский"
    puts "2. Грузовой"
    action = gets.chomp.to_i
     case action
       when 1
         puts "Чтобы создать пассажирский вагон, укажи его номер"
         number = gets.chomp.to_i
         puts "Укажи количество мест в вагоне"
         places = gets.chomp.to_i
         wagons << Passenger_wagon.new(number,places)
         puts "Создан пассажирский вагон #{number}, количество мест #{places}"
      when 2
        puts "Чтобы создать грузовой вагон, укажи его номер"
        number = gets.chomp.to_i
        puts "Укажи объем вагона"
        volume = gets.chomp.to_f
        wagons << Cargo_wagon.new(number,volume)
        puts "Создан грузовой вагон #{number}, объемом #{volume}"
      end
  end
 def change_wagons
   puts "Выбери поезд, у которого необходимо изменить кол-во вагонов"
   trains.each_with_index {|train, index| puts "#{train.number} - #{train.type}: #{index}"}
   train = gets.chomp.to_i
   puts "Выбран поезд #{trains[train]} тип поезда #{trains[train].type}"
   puts "Выбери что нужно сделать:
   1. Прицепить вагон
   2. Отцепить вагон"
    action = gets.chomp.to_i
      case action
      when 1
        puts "Выбери вагон, который необходимо прицепить"
        wagons.each_with_index {|wagon, index| puts "#{wagon.number} - #{wagon.type}: #{index}"}
        wagon = gets.chomp.to_i
        puts "Выбран вагон #{wagons[wagon].number} - #{wagons[wagon].type}"
        if trains[train].wagons.include?(wagons[wagon])
          puts "Вагон уже прицеплен"
        elsif trains[train].type == wagons[wagon].type
          trains[train].add_wagon(wagons[wagon])
          puts "Прицеплен вагон #{wagons[wagon].number}"
        else
          puts "Выбери другой вагон"
        end
      when 2
        puts "Выбери вагон, который необходимо отцепить"
        wagons.each_with_index {|wagon, index| puts "#{wagon.number} - #{wagon.type}: #{index}"}
        wagon = gets.chomp.to_i
        puts "Выбран вагон #{wagons[wagon].number} - #{wagons[wagon].type}"
        if trains[train].wagons.include?(wagons[wagon])
          trains[train].delete_wagon(wagons[wagon])
          puts "Отцеплен вагон #{wagons[wagon].number}"
        else
          puts "Такого вагона нет в составе"
        end
      end
 end

  def move_train
    puts "Выбери поезд, который необходимо переместить"
    trains.each_with_index {|train, index| puts "#{train.number}: #{index}"}
    train = gets.chomp.to_i
    puts "Выбран поезд #{trains[train]}"
    puts "Выбери станцию, на которую переместить поезд"
    stations.each_with_index {|station, index| puts "#{station.name}: #{index}"}
    station = gets.chomp.to_i
    puts "Выбрана станция #{stations[station]}"
    stations[station].add_train(train)
  end

  def stations_list
      stations.each {|station| puts "Список станций: #{station.name}"}
  end

  def trains_list
      stations.each do |station|
        puts " На станции #{station.name}:"
          if station.trains.size >=1
            station.trains.each {|train| puts "#{train.number}"}
          else
            puts "Nothing"
          end
      end
  end

  def train_wagons
    puts "Выбери поезд у которого необходимо посмотреть вагоны"
    trains.each_with_index {|train, index| puts "#{train.number}: #{index}"}
    train = gets.chomp.to_i
    puts "Выбран поезд #{trains[train]}"
    trains[train].each_wagon {|x| puts x}
  end

  def station_trains
    uts "Выбери станцию у которой необходимо посмотреть поезда"
    stations.each_with_index {|station, index| puts "#{station.name}: #{index}"}
    station = gets.chomp.to_i
    puts "Выбрана станция #{stations[station]}"
    stations[station].each_train {|x| puts x}
  end

  def take_place
    puts "Выбери вагон в котором необходимо занять место"
    wagons.each_with_index do |wagon, index|
      if wagon.type == :Passenger
        puts "#{wagon.number}: #{index}"
      end
    end
    wagon = gets.chomp.to_i
    puts "Выбран вагон #{wagons[wagon].number} - свободных мест #{wagons[wagon].free_places}"
    puts "Чтобы занять место нажми 1"
    action = gets.chomp.to_i
     if action == 1
       wagons[wagon].take_place
       puts "Осталось мест #{wagons[wagon].free_places}"
     end
  end

  def reduse_volume
    puts "Выбери вагон в котором необходимо занять место"
    wagons.each_with_index do |wagon, index|
      if wagon.type == :Cargo
        puts "#{wagon.number}: #{index}"
      end
    end
    wagon = gets.chomp.to_i
    puts "Выбран вагон #{wagons[wagon].number} - свободного места #{wagons[wagon].free_volume}"
    puts "Чтобы занять место, укажи объем не превышающий доступный объем"
    busy_volume = gets.chomp.to_f
       wagons[wagon].reduse_volume(busy_volume)
       puts "Осталось места #{wagons[wagon].free_volume}"
  end
end
Main.new.menu
