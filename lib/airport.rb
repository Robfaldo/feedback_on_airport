require_relative './plane.rb'

class Airport

  # You've not decided what methods are public and what methods are private. I would say weather generator, full?, stormy?, and maybe even other methods can be private. 

  attr_accessor :planes, :capacity

  def initialize(capacity = 30)
    @planes = []
    @capacity = capacity
  end

  # Avoid "magic number". I would do:
  #   DEFAULT_CAPACITY = 30
  #   def initialize(capacity = DEFAULT_CAPACITY)

  def land(plane)
    run_land_guards
    @planes << plane
    "Your plane has been successfully stored"
  end

  UNDEFINED = Object.new 
  # It's not clear what this is for. 

  def take_off(plane = UNDEFINED)
    # Why are you making an undefined object take off?
    # Wouldn't it be better to raise an error if
    # the specified plane isn't at the airport?
    run_take_off_guards(plane)
    # cool delegation of errors to separate method
    release_plane(plane)
    # cool delegation of taking off sequence to separate method
  end

  def run_land_guards
    fail "Plane can't land in stormy weather" if stormy?
    fail "Cannot land plane, airport is full" if full?
    # nice
  end

  def run_take_off_guards(plane)
    fail "That plane is not in this airport" if plane_not_in_airport(plane)
    fail "No planes available" if @planes.length.zero?
    fail "Plane can't take off in stormy weather" if stormy?
    # nice
  end

  def plane_not_in_airport(plane)
    plane != UNDEFINED && !check_plane(plane) 
    # I don't see the point of the whole undefined thing
    # did you just do this to satisfy a test?
    # you might not need this method at all, considering it just calls another method whose purpose is quite the same as this.
  end

  def release_plane(plane)
    if plane != UNDEFINED && check_plane(plane)
      # the name check_plane is confusing. plane_at_airport? might be better
      @planes.delete(plane)
      plane.take_flight
      return plane
    else 
      plane_to_return = @planes[-1] 
      @planes.pop
      # pop already returns @plane[-1], so plane_to_return is an unnecessary assignment
      return plane_to_return
    end
  end

  def check_plane(plane) 
    @planes.include?(plane) ? true : false
    # unnecessary ternary condition as @plane.include?(plane) returns true or false already
  end

  def stormy? 
    weather_generator >= 75
  end

  def weather_generator
    rand(100)
  end

  def full?
    @planes.length >= @capacity
  end

  def notify_plane(plane)
    plane.take_flight
  end
end
