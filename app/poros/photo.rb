class Photo
  attr_reader :url, :id

  def initialize(argument)
    @url = argument[:results][0][:urls][:raw]
    @id = argument[:results][0][:id]
  end
end
