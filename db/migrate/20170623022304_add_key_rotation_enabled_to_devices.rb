class AddKeyRotationEnabledToDevices < ActiveRecord::Migration[4.2]
  def change
    add_column :devices, :key_rotation_enabled, :boolean
  end
end
