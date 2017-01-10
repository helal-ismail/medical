class CreateInsuranceRelations < ActiveRecord::Migration
  def change
    create_table :insurance_relations do |t|
      t.string :entity_type
      t.integer :entity_id
      t.integer :insurance_company_id
      t.timestamps null: false
    end
  end
end
