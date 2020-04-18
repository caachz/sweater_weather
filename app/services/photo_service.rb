class PhotoService
  attr_reader :photo

  def initialize(location)
    conn = Faraday.new(url: "https://api.unsplash.com/search/photos?query=#{location}&client_id=#{ENV['UNSPLASH_API_KEY']}")

    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)

    @photo = Photo.new(json)
  end
end
