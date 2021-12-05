# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Main
  MENU = [
    { index: 1, menu_item: 'Создать станцию', action: :create_station },
    { index: 2, menu_item: 'Создать поезд', action: :create_train },
    { index: 3, menu_item: 'Создать маршрут', action: :create_route },
    { index: 4, menu_item: 'Изменить маршрут', action: :change_route },
    { index: 5, menu_item: 'Назначить поезду маршрут', action: :train_route },
    { index: 6, menu_item: 'Создать вагон', action: :create_wagon },
    { index: 7, menu_item: 'Изменить количество вагонов', action: :change_wagons },
    { index: 8, menu_item: 'Переместить поезд по маршруту', action: :move_train },
    { index: 9, menu_item: 'Посмотреть список станций', action: :list_stations_index },
    { index: 10, menu_item: 'Посмотреть список поездов', action: :trains_list },
    { index: 11, menu_item: 'Посмотреть список вагонов у поезда', action: :train_wagons },
    { index: 12, menu_item: 'Посмотреть список поездов на станции', action: :station_trains },
    { index: 13, menu_item: 'Занять место в пассажирском вагоне', action: :take_place },
    { index: 14, menu_item: 'Занять местов грузовом вагоне', action: :reduse_volume }
  ].freeze

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
      MENU.each { |item| puts "#{item[:index]}: #{item[:menu_item]}" }
      choice = gets.chomp.to_i
      action = MENU.find { |item| item[:index] == choice }
      send(action[:action])
    end
  end

  protected

  def create_station
    puts 'Введите название станции'
    name_station = gets.chomp.to_s
    stations << Station.new(name_station)
    puts "Создана станция #{name_station}"
  rescue StandardError => e
    puts e.message.to_s
  end

  def create_train
    puts "Выберите тип поезда который хотите создать:
    1. Пассажирский
    2. Грузовой"
    type_train = gets.chomp.to_i
    case type_train
    when 1
      create_passenger_train
    when 2
      create_cargo_train
    end
  rescue StandardError => e
    puts e.message.to_s
  end

  def create_passenger_train
    puts 'Введите номер пассажирского поезда в формате: aaa-aa,111-11,a1a-1a.'
    number_train = gets.chomp.to_s
    trains << PassengerTrain.new(number_train)
    puts "Создан пассажирский поезд #{number_train}"
  end

  def create_cargo_train
    puts 'Введите номер грузового поезда в формате: aaa-aa,111-11,a1a-1a.'
    number_train = gets.chomp.to_s
    trains << CargoTrain.new(number_train)
    puts "Создан грузовой поезд #{number_train}"
  end

  def create_route
    puts 'Введите название маршрута'
    route = gets.chomp.to_s
    list_stations_index
    puts 'Выберите начальную станцию'
    first_station_index = gets.chomp.to_i
    first_station = stations[first_station_index]
    puts 'Выберите конечную станцию'
    list_stations_index
    last_station_index = gets.chomp.to_i
    last_station = stations[last_station_index]
    route = Route.new(first_station, last_station)
    puts "Создан маршрут #{route}: с #{first_station} до #{last_station}"
    routes << route
  end

  def change_route
    puts 'Выбери номер маршрута, который нужно изменить'
    list_routes_index
    @route = gets.chomp.to_i
    puts "Выбран маршрут #{routes[@route]}"
    puts '1. Добавить станцию'
    puts '2. Удалить станцию'
    choice_routes = gets.chomp.to_i
    case choice_routes
    when 1
      puts 'Выберите станцию которую хотите добавить'
      list_stations_index
      @station = gets.chomp.to_i
      routes[@route].add_station(@station)
    when 2
      puts 'Введите станцию которую хотите удалить'
      station = gets.chomp.to_s
      routes[@route].delete_station(station)
    end
  end

  def train_route
    puts 'Выбери поезд, которому назначиить маршрут'
    list_trains_index
    @train = gets.chomp.to_i
    puts "Выбран поезд #{trains[@train]}"
    puts 'Выбери номер маршрута'
    list_routes_index
    @route = gets.chomp.to_i
    puts "Выбран маршрут #{routes[@route]}"
    trains[@train].add_route(routes[@route])
    puts "Поезду #{trains[@train]} присвоен маршрут #{routes[@route]}"
  end

  def create_wagon
    puts 'Выбери тип вагона который хочешь создать'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    action = gets.chomp.to_i
    case action
    when 1
      create_passenger_wagon
    when 2
      create_cargo_wagon
    end
  end

  def create_passenger_wagon
    puts 'Чтобы создать пассажирский вагон, укажи его номер'
    number = gets.chomp.to_i
    puts 'Укажи количество мест в вагоне'
    places = gets.chomp.to_i
    wagons << PassengerWagon.new(number, places)
    puts "Создан пассажирский вагон #{number}, количество мест #{places}"
  end

  def create_cargo_wagon
    puts 'Чтобы создать грузовой вагон, укажи его номер'
    number = gets.chomp.to_i
    puts 'Укажи объем вагона'
    places = gets.chomp.to_f
    wagons << CargoWagon.new(number, places)
    puts "Создан грузовой вагон #{number}, объемом #{places}"
  end

  def list_wagons_index
    wagons.each_with_index { |wagon, index| puts "#{wagon.number} - #{wagon.type}: #{index}" }
  end

  def hook_wagon
    puts 'Выбери вагон, который необходимо прицепить'
    list_wagons_index
    @wagon = gets.chomp.to_i
    puts "Выбран вагон #{wagons[@wagon].number} - #{wagons[@wagon].type}"
    if trains[@train].wagons.include?(wagons[@wagon])
      puts 'Вагон уже прицеплен'
    elsif trains[@train].type == wagons[@wagon].type
      trains[@train].add_wagon(wagons[@wagon])
      puts "Прицеплен вагон #{wagons[@wagon].number}"
    else
      puts 'Выбери другой вагон'
    end
  end

  def unhook_wagon
    puts 'Выбери вагон, который необходимо отцепить'
    list_wagons_index
    @wagon = gets.chomp.to_i
    puts "Выбран вагон #{wagons[wagon].number} - #{wagons[wagon].type}"
    if trains[@train].wagons.include?(wagons[@wagon])
      trains[@train].delete_wagon(wagons[@wagon])
      puts "Отцеплен вагон #{wagons[wagon].number}"
    else
      puts 'Такого вагона нет в составе'
    end
  end

  def change_wagons
    puts 'Выбери поезд, у которого необходимо изменить кол-во вагонов'
    list_trains_index
    @train = gets.chomp.to_i
    puts "Выбран поезд #{trains[@train]} тип поезда #{trains[@train].type}"
    puts "Выбери что нужно сделать:
    1. Прицепить вагон
    2. Отцепить вагон"
    action = gets.chomp.to_i
    case action
    when 1
      hook_wagon
    when 2
      unhook_wagon
    end
  end

  def move_train
    puts 'Выбери поезд, который необходимо переместить'
    list_trains_index
    @train = gets.chomp.to_i
    puts "Выбран поезд #{trains[train]}"
    puts 'Выбери станцию, на которую переместить поезд'
    list_stations_index
    @station = gets.chomp.to_i
    puts "Выбрана станция #{stations[@station]}"
    stations[@station].add_train(@train)
  end

  def trains_list
    stations.each do |station|
      puts " На станции #{station.name}:"
      if station.trains.size >= 1
        station.trains.each { |train| puts train.number.to_s }
      else
        puts 'Nothing'
      end
    end
  end

  def train_wagons
    puts 'Выбери поезд у которого необходимо посмотреть вагоны'
    list_trains_index
    @train = gets.chomp.to_i
    puts "Выбран поезд #{trains[@train]}"
    trains[@train].each_wagon { |x| puts x }
  end

  def station_trains
    puts 'Выбери станцию у которой необходимо посмотреть поезда'
    list_stations_index
    @station = gets.chomp.to_i
    puts "Выбрана станция #{stations[@station]}"
    stations[@station].each_train { |x| puts x }
  end

  def take_place
    puts 'Выбери вагон в котором необходимо занять место'
    list_wagons_index
    puts "#{wagon.number}: #{index}" if wagon.type == :Passenger
    wagon = gets.chomp.to_i
    puts "Выбран вагон #{wagons[wagon].number} - свободных мест #{wagons[wagon].free_places}"
    puts 'Чтобы занять место нажми 1'
    action = gets.chomp.to_i
    return unless action == 1
      wagons[wagon].take_place
      puts "Осталось мест #{wagons[wagon].free_places}"
  end

  def reduse_volume
    puts 'Выбери вагон в котором необходимо занять место'
    list_wagons_index
    puts "#{wagon.number}: #{index}" if wagon.type == :Cargo
    wagon = gets.chomp.to_i
    puts "Выбран вагон #{wagons[wagon].number} - свободного места #{wagons[wagon].free_places}"
    puts 'Чтобы занять место, укажи объем не превышающий доступный объем'
    occupied_place = gets.chomp.to_f
    wagons[wagon].reduse_volume(occupied_place)
    puts "Осталось места #{wagons[wagon].free_places}"
  end

  def list_stations_index
    stations.each_with_index { |station, index| puts "#{station.name}: #{index += 1}" }
  end

  def list_trains_index
    trains.each_with_index { |train, index| puts "#{train.number} - #{train.type}: #{index}" }
  end

  def list_routes_index
    routes.each_with_index { |name, index| puts "#{name}: #{index}" }
  end
end
Main.new.menu
