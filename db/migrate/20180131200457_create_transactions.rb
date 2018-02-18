class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :broker, index: true, foreign_key: true
      t.belongs_to :stock, foreign_key: true
      t.integer :shares
      t.integer :day
    
      t.string :action

      t.timestamps
    end
  end
end
