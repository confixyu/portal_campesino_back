class AddPriceFieldToPurchases < ActiveRecord::Migration[6.0]
  def change
    add_column :purchases, :total_to_pay, :float
    add_column :purchases, :sub_total, :float
    add_column :purchases, :transport_cost, :float
  end
end
