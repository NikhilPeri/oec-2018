class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.integer :price, :limit => 8
      t.belongs_to :exchange, index: { unique: true }, foreign_key: true


      t.float :annual_vec
      t.float :intermediate_vec
      t.float :daily_vec

      t.integer :historical_price, array: true, default: []

      t.timestamps
    end
  end
end
