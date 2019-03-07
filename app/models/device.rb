class Device < ActiveRecord::Base
  belongs_to :user
  has_many :device_access_tokens, dependent: :destroy
  has_many :log_data, dependent: :destroy
  has_many :device_webhooks, dependent: :destroy
  has_many :webhooks, -> { distinct }, through: :device_webhooks

  validates :uuid, presence: true, uniqueness: true

  after_initialize do |device|
    device.uuid = SecureRandom.uuid unless device.uuid
  end

  def current_valid_token
    device_access_tokens.where("sequence > ?", last_used_key_sequence).order(:sequence).first ||
      device_access_tokens.order(:sequence).first
  end
end
