class AntipodeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :forecast, :search_location, :location_name
end
