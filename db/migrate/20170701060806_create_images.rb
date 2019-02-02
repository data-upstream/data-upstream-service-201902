class CreateImages < ActiveRecord::Migration[4.2]
  def change
    create_table :images do |t|
      t.references :log_datum, index: true, foreign_key: true
      #t.attachment :image

      t.timestamps null: false
    end
  end
end
