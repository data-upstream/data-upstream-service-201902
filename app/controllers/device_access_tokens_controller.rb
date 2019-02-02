class DeviceAccessTokensController < ApplicationController
  before_action :require_read_write_user_access_token
  before_action :assign_device

  def index
    @access_tokens = @device.device_access_tokens.order(id: :desc).paginate(page: params[:page], per_page: params[:limit])
    render json: @access_tokens.reverse
  end

  private

  def assign_device
    @device = current_user.devices.find_by(id: params[:device_id])
    render json: {errors: ["Device ID not found"]}, status: :forbidden unless @device
  end
end
