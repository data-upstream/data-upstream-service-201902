class AddUserToDevices < ActiveRecord::Migration[4.2]
  def change
    add_reference :devices, :user, index: true, foreign_key: true
  end
end
