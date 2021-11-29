require_relative 'manufacturer'


class Wagon

TYPE_WAGON = /[cargo][passenger]/i


    attr_reader :type
    attr_reader :number

    include Manufacturer

  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

protected
  def validate!
    raise "Incorrect type" if type !~ TYPE_WAGON
  end

end
