class AddRefrencesToDonorsCases < ActiveRecord::Migration[6.0]
  def change
    add_reference :donors_cases, :donor, null: false, foreign_key: {on_delete: :cascade}
  end
end
