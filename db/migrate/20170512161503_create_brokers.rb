class CreateBrokers < ActiveRecord::Migration[5.1]
  def change
    create_table :brokers do |t|
      t.string :name
      t.integer :cash, :limit => 8
      t.string :token

      t.timestamps
    end
  end
end
