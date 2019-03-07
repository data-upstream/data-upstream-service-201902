class RemoveDeviceFromWebhooks < ActiveRecord::Migration[5.2]
  remove_reference :webhooks, :device, index: true
end
