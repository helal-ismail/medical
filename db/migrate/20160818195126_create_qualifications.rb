class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.integer :degree
      t.integer :title
      t.integer :specialization_id
      t.date :graduation_year
      t.text :description
      t.timestamps null: false
    end
  end
end
