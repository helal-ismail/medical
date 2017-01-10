class CreateInsuranceCompanies < ActiveRecord::Migration
  def change
    create_table :insurance_companies do |t|
      t.string :uid
      t.string :name
      t.text :description
      t.string :address
      t.timestamps null: false
    end
  end
end
