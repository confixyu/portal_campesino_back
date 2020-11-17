class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.integer :product_id
      t.float :quantity
      t.string :client_name
      t.integer :phone
      t.string :address
      t.string :state
      t.string :city

      t.timestamps
    end
  end
end
