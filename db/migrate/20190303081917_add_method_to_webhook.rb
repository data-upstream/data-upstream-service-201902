class AddMethodToWebhook < ActiveRecord::Migration[5.2]
  def change
    add_column :webhooks, :method, :string
  end
end
