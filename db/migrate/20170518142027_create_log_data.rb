class CreateLogData < ActiveRecord::Migration[4.2]
  def change
    create_table :log_data do |t|
      t.references :device, index: true, foreign_key: true
      t.json :payload

      t.timestamps null: false
    end
  end
end
