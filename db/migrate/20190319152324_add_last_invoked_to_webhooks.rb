class AddLastInvokedToWebhooks < ActiveRecord::Migration[5.2]
  def change
    add_column :webhooks, :last_invoked, :json
  end
end
