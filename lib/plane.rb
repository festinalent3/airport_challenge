require 'airport'

class Plane
  attr_reader :landed, :airport

  def initialize(airport)
    @airport = airport
  end

  def land(airport)
    @airport = airport
    @landed = true
  end

  def take_off
    raise "Can't take off in stormy weather" if airport.weather == "stormy"
    @landed = false
    true
  end

  def landed?
    landed
  end

  private
  attr_writer :landed, :airport

end