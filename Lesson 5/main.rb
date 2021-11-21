
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
  6. Изменить количество вагонов
  7. Переместить поезд по маршруту
  8. Посмотреть список станций
  9. Посмотреть список поездов"

  attr_accessor :trains,
                :stations,
                :routes


  def initialize
    @trains = []
    @routes = []
    @stations = []
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
          change_wagons
        when 7
          move_train
        when 8
          stations_list
        when 9
          trains_list
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
  end

  def create_train
    puts "Выберите тип поезда который хотите создать:
    1. Пассажирский
    2. Грузовой"
    type_train = gets.chomp.to_i
    case type_train
      when 1
        puts "Введите номер пассажирского поезда"
        num_train = gets.chomp.to_s
        trains << Passenger_train.new(num_train)
        puts "Создан пассажирский поезд #{num_train}"
      when 2
        puts "Введите номер грузового поезда"
        num_train = gets.chomp.to_s
        trains << Cargo_train.new(num_train)
        puts "Создан грузовой поезд #{num_train}"
    end
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
    ch_routes = gets.chomp.to_i
          case ch_routes
            when 1
              puts "Выберите станцию которую хотите добавить"
              stations.each_with_index{|station, index| puts "#{station.name}: #{index}"}
              station = gets.chomp.to_i
              routes[route_index].add_station(station)
            when 2
              puts "Введите станцию которую хотите удалить"
              station = gets.chomp.to_s
              routes[route_index].del_station(station)
          end
  end

  def train_route
    puts "Выбери поезд, которому назначиить маршрут"
    trains.each_with_index {|train, index| puts "#{train.num} - #{train.type}: #{index}"}
    train_index = gets.chomp.to_i
    puts "Выбран поезд #{trains[train_index]}"
    puts "Выбери номер маршрута"
    routes.each_with_index {|name, index| puts "#{name}: #{index}"}
    route_index = gets.chomp.to_i
    puts "Выбран маршрут #{routes[route_index]}"
    trains[train_index].add_route(routes[route_index])
    puts "Поезду #{trains[train_index]} присвоен маршрут #{routes[route_index]}"
  end

  def change_wagons
    puts "Выбери поезд, у которого необходимо изменить кол-во вагонов"
    trains.each_with_index {|train, index| puts "#{train.num}: #{index}"}
    train = gets.chomp.to_i
    puts "Выбран поезд #{trains[train]}"
    puts "Выбери что нужно сделать:
    1. Прицепить вагон
    2. Отцепить вагон"
    action = gets.chomp.to_i
      case action
      when 1
        if trains[train].type == :Cargo
          trains[train].add_wagon(Cargo_wagon.new)
        else
          trains[train].add_wagon(Passenger_wagon.new)
        end
      when 2
        if trains[train].type == :Cargo
          trains[train].del_wagon(Cargo_wagon.new)
        else
          trains[train].del_wagon(Passenger_wagon.new)
        end
      end
  end

  def move_train
    puts "Выбери поезд, который необходимо переместить"
    trains.each_with_index {|train, index| puts "#{train.num}: #{index}"}
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
          station.trains.each {|train| puts "#{train.num}"}
          else
          puts "Nothing"
          end
      end
    end
end

Main.new.menu
