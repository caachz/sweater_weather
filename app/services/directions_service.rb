class DirectionsService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def distance_text
    get_json[:routes][0][:legs][0][:duration][:text]
  end

  def distance_value
    get_json[:routes][0][:legs][0][:duration][:value]
  end

  private
    def connection
      Faraday.new(url: 'https://maps.googleapis.com') do |faraday|
        faraday.params["key"] = ENV["GOOGLE_API_KEY"]
      end
    end

    def get_directions
      response = connection.get("maps/api/directions/json") do |f|
        f.params["origin"] = @origin
        f.params["destination"] = @destination
        f.params["key"] = ENV['GOOGLE_API_KEY']
      end
    end

    def get_json
      response = get_directions

      JSON.parse(response.body, symbolize_names: true)
    end
end
