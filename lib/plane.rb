class Plane

  attr_accessor :flying_status

  def initialize 
    @flying_status = false
  end

  def flying?
    @flying_status
  end

  def take_flight
    @flying_status = true
  end

  # is there no method to make the plane stop flying when it's landed?
end
