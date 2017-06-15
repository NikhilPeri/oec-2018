class CreateBrokers < ActiveRecord::Migration[5.1]
  def change
    create_table :brokers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :token
      t.integer :cash, :limit => 8

      t.timestamps
    end
  end
end
