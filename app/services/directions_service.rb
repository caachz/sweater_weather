class DirectionsService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def conn
    Faraday.new(url: "https://maps.googleapis.com/maps/api/directions/json?origin=#{@origin}&destination=#{@destination}&key=#{ENV['GOOGLE_API_KEY']}")
  end

  def get
    conn.get
  end

  def parse_json
    response = get
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def distance_text
    parse_json[:routes][0][:legs][0][:duration][:text]
  end

  def distance_value
    parse_json[:routes][0][:legs][0][:duration][:value]
  end
end
