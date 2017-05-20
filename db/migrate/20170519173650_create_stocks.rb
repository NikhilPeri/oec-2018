class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.integer :price, :limit => 8

      t.integer :annual_vec, :limit => 5
      t.integer :quarterly_vec, :limit => 5
      t.integer :monthly_vec, :limit => 5
      t.integer :week_vec, :limit => 5
      t.integer :day_vec, :limit => 5

      t.timestamps
    end
  end
end
