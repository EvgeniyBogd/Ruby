class Wagon

  attr_accessor :volume

  def initialize(volume)
    @volume = volume.to_f
    @busy_volume = 0
  end

  def reduse_volume(busy_volume)
    @busy_volume += busy_volume.to_f if @busy_volume + busy_volume.to_f < volume
  end

  def busy_volume
    @busy_volume
  end

  def free_volume
    @free_volume = volume - @busy_volume
    @free_volume
  end

end
