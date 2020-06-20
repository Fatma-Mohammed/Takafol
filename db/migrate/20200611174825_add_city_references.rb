class AddCityReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :cities, :governorate, null: false, foreign_key: {on_delete: :cascade}

  end
end
