class Location
  attr_reader :name, :lat, :lng

  def initialize(args)
    @lat = args[:lat]
    @lng = args[:lng]
    @name = args[:name]
  end
end
