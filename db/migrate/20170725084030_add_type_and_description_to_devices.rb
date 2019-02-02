class AddTypeAndDescriptionToDevices < ActiveRecord::Migration[4.2]
  def change
    add_column :devices, :stream_type, :string
    add_column :devices, :description, :text
  end
end
