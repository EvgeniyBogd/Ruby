class Main
  def initialize
    sttr_accessor :stations
                  :routes
                  :trains
                  :wagons
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end
  
  menu =
  puts "
  1. Создать станцию.
  2. Создать поезд.
  3. Создать маршрут.
  4. Изменить маршрут.
  5. Назначить поезду маршрут.
  6. Изменить количество вагонов.
  7. Переместить поезд по маршруту.
  8. Посмотреть список станций.
  9. Посмотреть список поездов на станции."
  answ = gets.chomp.to_s

  case answ
    when "1" then create_station
    when "2" then create_train 
    when "3" then create_route
    when "4" then change_route
    when "5" then train_route
    when "6" then change_wagons
    when "7" then move_train
    when "8" then look_stations
    when "9" then lokk_train
  end

  protected

  def create_station
    puts "Введите название станции"
    name_station = gets.chomp.to_s
    stations << Station.new(station_name)
    puts "Создана станция #{station_name}!"
  end

  def create_train
    puts "Выберите тип поезда который хотите создать:
    1. Пассажирский.
    2. Грузовой."
    type_train = gets.chomp.to_i
  
    case type_train
      when 1 then
        puts "Введите номер пассажирского поезда"
        num_train = gets.chomp.to_s
        trains << Passenger_train.new(num_train)
        puts "Создан пассажирский поезд #{num_train}!"
      when 2 then
        puts "Введите номер грузового поезда"
        num_train = gets.chomp.to_s
        trains << Cargo_train.new(num_train)
        puts "Создан грузовой поезд #{num_train}!" 
    end
  end

  def create_route
    puts "Введите название маршрута"
    route = gets.chomp.to_s
    puts "Введите начальную станцию!"
    first_station = gets.chomp.to_s
    puts "Введите конечную станцию!"
    last_station = gets.chomp.to_s
    routes << Route.new(:stations[first_station], :stations[last_station])
  end

  def change_route
    puts "Выбери номер маршрута, который нужно изменить"
    routes {|name, index|}
    puts "#{name}: #{index}"
    take_routes = gets.chomp.to_i
    puts "1. Добавить станцию!
          2. Удалить станцию! "  
end
