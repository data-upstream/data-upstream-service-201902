module Api::V1::Concerns::WebhooksExecutor
  extend ActiveSupport::Concern

  module Events
    LOG_DATA_CREATED = "log_data_created"
    IMAGES_CREATED   = "images_created"
  end

  def execute_webhook(webhook, event, payload)
    # TODO: insert current_device's device_id into request_boy
    request_body = {
      secret: webhook.secret, # substitute with secret from header;
      event: event, # remove event from request_body;
      data: payload
    }

    # TODO: post based on method saved on webook model
    # url here can be external cloud
    # TODO: check RestClient whether can support port
    RestClient.post webhook.url, request_body.to_json, {content_type: :json}
  rescue => e
  end
end
