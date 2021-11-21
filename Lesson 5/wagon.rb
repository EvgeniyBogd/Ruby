class Wagon
    attr_reader :type

  def initialize(type)
    @type = type
    include Manufacturer
  end
end
