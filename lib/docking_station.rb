class DockingStation
  DEFAULT_CAPACITY = 20

  attr_reader :bikes
  attr_reader :capacity

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    raise "No bikes available" if empty?
    @bikes.each do |bike|
      if bike.working == true
        @bikes.delete(bike)
        return bike
      end
    end
    raise "No working bikes available"
  end

  def dock_bike(bike, working=true)
    if !working
      bike.working = false
    end
    raise "Docking station is full" if full?
    @bikes << bike
  end

private

  def empty?
    @bikes.empty?
  end

  def full?
    @bikes.count == @capacity
  end

end


class Bike
  attr_accessor :working
  def initialize(working = true)
    @working = working
  end

end
