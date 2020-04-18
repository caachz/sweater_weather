class Forecast
  attr_reader :id

  def initialize(params)
    @params = params
    @id = 1
  end

  def today
    {temp_now: @params[:current][:temp],
    high_temp: @params[:daily][0][:temp][:max],
    low_temp: @params[:daily][0][:temp][:min],
    today_description: @params[:current][:weather][0][:description],
    today_feels_like: @params[:current][:feels_like],
    today_humidity: @params[:current][:humidity],
    today_visibilty: @params[:current][:visibility],
    today_uv_index: @params[:current][:uvi],
    today_sunrise: @params[:current][:sunrise],
    today_sunset: @params[:current][:sunset]
    }
  end

  def hourly
    {one_hour: {date_time: @params[:hourly][0][:dt],
                description: @params[:hourly][0][:weather][0][:description],
                temp: @params[:hourly][0][:temp]},
      two_hours: {date_time: @params[:hourly][1][:dt],
                description: @params[:hourly][1][:weather][0][:description],
                temp: @params[:hourly][1][:temp]},
      three_hours: {date_time: @params[:hourly][2][:dt],
                description: @params[:hourly][2][:weather][0][:description],
                temp: @params[:hourly][2][:temp]},
      four_hours: {date_time: @params[:hourly][3][:dt],
                description: @params[:hourly][3][:weather][0][:description],
                temp: @params[:hourly][3][:temp]},
      five_hours: {date_time: @params[:hourly][4][:dt],
                description: @params[:hourly][4][:weather][0][:description],
                temp: @params[:hourly][4][:temp]},
      six_hours: {date_time: @params[:hourly][5][:dt],
                description: @params[:hourly][5][:weather][0][:description],
                temp: @params[:hourly][5][:temp]},
      seven_hours: {date_time: @params[:hourly][6][:dt],
                description: @params[:hourly][6][:weather][0][:description],
                temp: @params[:hourly][6][:temp]},
      eight_hours: {date_time: @params[:hourly][7][:dt],
                description: @params[:hourly][7][:weather][0][:description],
                temp: @params[:hourly][7][:temp]}}
  end

  def daily
    {day_1: {
        description: @params[:daily][0][:weather][0][:description],
        mm_rain: @params[:daily][0][:rain],
        high_temp: @params[:daily][0][:temp][:max],
        low_temp: @params[:daily][0][:temp][:min]
      },
      day_2: {
          description: @params[:daily][1][:weather][0][:description],
          mm_rain: @params[:daily][1][:rain],
          high_temp: @params[:daily][1][:temp][:max],
          low_temp: @params[:daily][1][:temp][:min]
        },
      day_3:{
          description: @params[:daily][2][:weather][0][:description],
          mm_rain: @params[:daily][2][:rain],
          high_temp: @params[:daily][2][:temp][:max],
          low_temp: @params[:daily][2][:temp][:min]
        },
      day_4:{
          description: @params[:daily][3][:weather][0][:description],
          mm_rain: @params[:daily][3][:rain],
          high_temp: @params[:daily][3][:temp][:max],
          low_temp: @params[:daily][3][:temp][:min]
        },
      day_5:{
          description: @params[:daily][4][:weather][0][:description],
          mm_rain: @params[:daily][4][:rain],
          high_temp: @params[:daily][4][:temp][:max],
          low_temp: @params[:daily][4][:temp][:min]}}
  end
end
