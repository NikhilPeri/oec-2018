class CreateExchanges < ActiveRecord::Migration[5.1]
  def change
    create_table :exchanges do |t|
      t.integer :day, limit: 8
      t.integer :update_frequency, limit: 2
      t.boolean :live

      t.timestamps
    end
  end
end
