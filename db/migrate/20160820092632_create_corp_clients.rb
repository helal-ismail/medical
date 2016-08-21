class CreateCorpClients < ActiveRecord::Migration
  def change
    create_table :corp_clients do |t|
      t.string :uid      
      t.string :name
      t.text :address
      t.string :field
      t.string :phone
      t.string :email
      
      t.timestamps null: false
    end
  end
end
