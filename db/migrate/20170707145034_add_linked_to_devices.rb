class AddLinkedToDevices < ActiveRecord::Migration[4.2]
  def change
    add_column :devices, :linked, :boolean, null: false, default: false
  end
end
