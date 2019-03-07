class CreateDeviceWebhooks < ActiveRecord::Migration[5.2]
  def change
    create_table :device_webhooks do |t|
      t.references :device
      t.references :webhook
      t.timestamp
    end
  end
end
