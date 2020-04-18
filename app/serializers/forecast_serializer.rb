class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :today, :hourly, :daily, :id
end
