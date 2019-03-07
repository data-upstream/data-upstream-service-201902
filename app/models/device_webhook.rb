class DeviceWebhook < ApplicationRecord
  belongs_to :device
  belongs_to :webhook
end