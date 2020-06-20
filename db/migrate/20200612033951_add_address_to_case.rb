class AddAddressToCase < ActiveRecord::Migration[6.0]
  def change
    add_reference :cases, :city, null: false, foreign_key: true
  end
end
