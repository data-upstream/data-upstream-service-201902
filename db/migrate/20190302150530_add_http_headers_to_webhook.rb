class AddHttpHeadersToWebhook < ActiveRecord::Migration[5.2]
  def change
    add_column :webhooks, :http_headers, :json, array: true, default: []
  end
end
