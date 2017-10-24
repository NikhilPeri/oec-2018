class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.belongs_to :exchange, index: true , foreign_key: true

      t.timestamps
    end
  end
end
