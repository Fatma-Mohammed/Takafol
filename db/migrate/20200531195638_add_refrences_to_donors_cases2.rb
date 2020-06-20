class AddRefrencesToDonorsCases2 < ActiveRecord::Migration[6.0]
  def change
    add_reference :donors_cases, :case, null: false, foreign_key: {on_delete: :cascade}
  end
end
