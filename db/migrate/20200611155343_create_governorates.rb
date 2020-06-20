class CreateGovernorates < ActiveRecord::Migration[6.0]
  def change
    create_table :governorates do |t|
      t.string :name
      t.string :name_en
      
    end
  end
end
