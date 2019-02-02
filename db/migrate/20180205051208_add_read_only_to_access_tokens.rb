class AddReadOnlyToAccessTokens < ActiveRecord::Migration[4.2]
  def change
    add_column :access_tokens, :read_only, :boolean, default: false
  end
end
