class Webhook < ActiveRecord::Base
  has_many :device_webhooks, dependent: :destroy
  has_many :devices, -> { distinct }, through: :device_webhooks

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25}
  validates :url, presence: true, format: { with: /\A(https:\/\/)((www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}|localhost)(.*)\z/, on: :create }
  validates :devices, presence: true
end
