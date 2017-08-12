class CreateHoldings < ActiveRecord::Migration[5.1]
  def change
    create_table :holdings do |t|
      t.belongs_to :broker, index: true, foreign_key: true
      t.belongs_to :stock, foreign_key: true
      t.integer :shares, limit: 8, default: 0
      t.integer :book_cost, limit: 8

      t.timestamps
    end
  end
end
