module Api::V1

  class Users::WebhooksController < ApplicationController
    include Api::V1::Concerns::Sessions

    before_action :require_read_write_user_access_token
    before_action :check_device, only: [:create, :update, :destroy]
    before_action :check_device_webhook, only: [:update, :destroy]

    def index
      # get just the user device ids in an array - unfortunately, for the query, it needs to be constructed like this due to JOIN statements
      device_ids_arr = get_current_user_devices

      @webhooks = get_webhook_with_device_ids(device_ids_arr);

      render json: @webhooks
    end

    def create
      @webhook = Webhook.new(webhook_params)

      if @webhook.save
        render json: @webhook
      else
        render json: {errors: @webhook.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def update
      @webhook = Webhook.find(params[:id])
      if @webhook.update(webhook_params)
        render json: @webhook
      else
        render json: {errors: @webhook.errors.full_messages}, status: :unprocessable_entity
      end
    end

    def destroy
      # check if webhook in device_webhooks is used in more than one device
      # if yes, delete only the device_webhooks record for this device id and webhook id
      # if only one webhook record is left, destroy webhook
      all_webhooks = DeviceWebhook.where(webhook_id: params[:id])
      if all_webhooks.count > 1
        all_webhooks.find_by(device_id: params[:stream_id]).destroy
      else
        Webhook.find(params[:id]).destroy
      end
      render nothing: true, status: :no_content
    end

    private

    def webhook_params
      params.permit(:url, :name, :method, :active, :secret, :http_headers => [:key, :value], device_ids: [])
    end

    def get_current_user_devices
      devices = current_user.devices
      device_ids_arr = []
      devices.each { |d| device_ids_arr.push(d.id) }
      device_ids_arr
    end

    def check_device
      # check if user has the stream_id or device_ids params as sent
      if params[:stream_id]
        @device_ids = [params[:stream_id].to_i]
      else
        @device_ids = params[:device_ids]  
      end
   
      if (@device_ids.is_a?(Array) && @device_ids.first)
        device_ids_arr = get_current_user_devices
        
        # check whether the device_ids provided is a subset of user's total device ids
        render json: {errors: ["Device ID not found"]}, status: :forbidden unless device_ids_arr.to_set.superset? @device_ids.to_set
      end
    end

    def check_device_webhook
      # check if webhook is under this device under this user
      webhook_id = params[:id]
      device_webhook = DeviceWebhook.where(device: current_user.devices).find_by(webhook_id: webhook_id)
      unless device_webhook
        render json: {errors: ["Webhook ID #{webhook_id} not found"]}, status: :forbidden
      end
    end

    def get_webhook_with_device_ids(device_ids)
      Webhook.includes(:devices).where("devices.id": device_ids).references(:devices)
    end
  end

end
