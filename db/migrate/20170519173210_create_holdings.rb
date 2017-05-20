class CreateHoldings < ActiveRecord::Migration[5.1]
  def change
    create_table :holdings do |t|
      t.belongs_to :broker, index: { unique: true }, foreign_key: true
      t.integer :stock_id
      t.integer :shares, :limit => 8
      t.integer :book_cost, :limit => 8

      t.timestamps
    end
  end
end
