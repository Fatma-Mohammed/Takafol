class AddRefrencesToCharitiesCases < ActiveRecord::Migration[6.0]
  def change
    add_reference :charities_cases, :charity, null: false, foreign_key: {on_delete: :cascade}
  end
end
