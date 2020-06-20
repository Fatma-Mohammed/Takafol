class CreateCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.string :name
      t.string :job
      t.text :description
      t.integer :children_num
      t.string :marital_status
      t.string :email
      t.integer :priority
      t.string :phone
      t.string :address
      t.string :national_id, null: false
      t.string :NID_img
      t.decimal :amount_needed , :default => 500
      t.decimal :amount_obtained ,  :default => 0
      t.timestamps
    end
  end
end
