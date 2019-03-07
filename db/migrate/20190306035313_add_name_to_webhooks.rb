class AddNameToWebhooks < ActiveRecord::Migration[5.2]
  def change
    add_column :webhooks, :name, :string
  end
end
