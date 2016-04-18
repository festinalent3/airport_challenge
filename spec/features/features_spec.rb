require 'airport'
require 'plane'

feature 'Feature Tests' do

  scenario 'Landing a flying plane at an airport' do
    plane_lands_and_report_that_it_has_landed
  end

  scenario 'Plane takes off from airport & confirms leaving' do
    landed_takes_off_and_report_leaving
  end

  scenario 'Prevent take off in story weather' do
    prevent_take_off_when_stormy_weather
  end

  scenario 'Prevent landing in stormy weather' do
    prevent_landing_when_stormy_weather
  end

  scenario 'Prevent landing when airport is full' do
    prevent_landing_when_airport_is_full
  end

  scenario 'Override default capacity' do
    override_default_capacity
  end

  scenario 'Take off and land some planes' do
    take_off_and_land_some_planes
  end


  def plane_lands_and_report_that_it_has_landed
    airport = Airport.new
    plane = Plane.new(airport)
    airport.update_weather until airport.update_weather == "sunny"
    plane.take_off(plane, airport)
    plane.land(plane, airport)
    plane.landed?
  end

  def landed_takes_off_and_report_leaving
    airport = Airport.new
    plane = Plane.new(airport)
    airport.update_weather until airport.update_weather == "sunny"
    airport.take_off(plane, airport)
    plane.current_airport
    plane.flying?
  end

  def prevent_take_off_when_stormy_weather
    message = "Can't take off in stormy weather"
    airport = Airport.new
    plane = Plane.new(airport)
    airport.update_weather until airport.update_weather == "stormy"
    expect { airport.take_off(plane, airport) }.to raise_exception message
  end

  def prevent_landing_when_stormy_weather
    message = "Can't land in stormy weather"
    airport = Airport.new
    plane = Plane.new(airport)
    airport.update_weather until airport.update_weather == "sunny"
    plane.take_off(plane, airport)
    airport.update_weather until airport.update_weather == "stormy"
    expect { airport.land(plane, airport) }.to raise_exception message
  end

  def prevent_landing_when_airport_is_full
    message = "Can't land in full airport"
    airport = Airport.new(0)
    plane = Plane.new(airport)
    airport.update_weather until airport.update_weather == "sunny"
    plane.take_off(plane, airport)
    expect { airport.land(plane, airport) }.to raise_exception message
  end

  def override_default_capacity
    airport = Airport.new
    airport.capacity = 3000
    expect(Airport::DEFAULT_CAPACITY).not_to eq(airport.capacity)
  end

    def take_off_and_land_some_planes
      airport = Airport.new
      destination = Airport.new
      plane1 = Plane.new(airport)
      plane2 = Plane.new(airport)
      plane3 = Plane.new(airport)
      plane4 = Plane.new(airport)
      plane5 = Plane.new(airport)

      airport.update_weather until airport.update_weather == "sunny"
      5.times do
      airport.take_off(airport.planes.last, airport)
      end

      destination.update_weather until destination.update_weather == "sunny"
      destination.land(plane1, destination)
      destination.update_weather until destination.update_weather == "sunny"
      destination.land(plane2, destination)
      destination.update_weather until destination.update_weather == "sunny"
      destination.land(plane3, destination)
    end

end
