class AddDeviceIdsToWebhooks < ActiveRecord::Migration[5.2]
  def change
    add_column :webhooks, :device_ids, :integer, array: true, default: []
  end
end
