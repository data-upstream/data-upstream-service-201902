module Api::V1::Concerns::WebhooksExecutor
  extend ActiveSupport::Concern

  module Events
    LOG_DATA_CREATED = "log_data_created"
    IMAGES_CREATED   = "images_created"
  end

  def execute_webhook(webhook, event, payload)
    
    secret_value = nil
    # extract out the secret key from header if any
    if (webhook[:http_headers] && webhook[:http_headers].is_a?(Array))
      secret_obj = webhook[:http_headers].find { |i| i['key'] === 'secret' }
      secret_value = secret_obj && secret_obj['value']
    end

    request_body = {
      secret: secret_value,
      data: payload # device id is contained in payload
    }

    # RestClient.post webhook.url, request_body.to_json, {content_type: :json}
    # due to insecure SSL
    method = webhook[:method] || "POST"
    response = RestClient::Request.execute(method: method, url: webhook.url, payload: request_body.to_json, headers: {content_type: :json}, verify_ssl: false)
  rescue => e
  end
end
