class CreateAccessTokens < ActiveRecord::Migration[4.2]
  def change
    create_table :access_tokens do |t|
      t.string :token
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
