class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :username
      t.string :phone
      t.string :salt
      t.string :encrypted_password
      t.string :access_token
      t.string :channel
      t.integer :gender
      t.string :address
      t.string :type
      t.date   :date_of_birth
      t.integer :qualification_id
      t.timestamps null: false
    end
  end
end
