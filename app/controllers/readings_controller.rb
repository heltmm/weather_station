class ReadingsController < ApplicationController

  before_action :authenticate, except: [:index]

  def index
    @readings =  Reading.all
    json_response(@readings)
  end

  def create
    # need error message if device doesn't exist
    @device = @client.devices.find(params[:device_id])
    @reading = @device.readings.create!(reading_params)
    @readings =  @device.readings

    ActionCable.server.broadcast('readings', reading: @reading)
    json_response(@reading)
  end

  private


  def reading_params
    params.permit(:temperature, :humidity, :device_id, :id)
  end

  def authenticate
    api_key = request.headers['HTTP_API_KEY']
    @client = Client.where(api_key: api_key).first if api_key
      unless @client
        head status: :unauthorized
      return false
    end
  end

end
