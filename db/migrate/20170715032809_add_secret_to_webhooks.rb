class AddSecretToWebhooks < ActiveRecord::Migration[4.2]
  def change
    add_column :webhooks, :secret, :string
  end
end
