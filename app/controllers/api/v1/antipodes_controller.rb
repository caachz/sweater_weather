class Api::V1::AntipodesController < ApplicationController
  def show
    info = AntipodeFacade.new(params["location"])

    render json: AntipodeSerializer.new(info)
#     render json: {
#     "data": {
#         "id": "null",
#         "type": "antipode",
#         "attributes": {
#             "location_name": info.antipode_name.city_name,
#             "forecast": {
#                 "summary": info.antipode_weather.forecast.today[:today_description],
#                 "current_temperature": info.antipode_weather.forecast.today[:temp_now],
#             },
#             "search_location": params["location"]
#         }
#     }
# }
  end
end
