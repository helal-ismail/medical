class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :entity_id
      t.string :entity_type
      t.integer :stars
      t.text :comment
      t.timestamps null: false
    end
  end
end
