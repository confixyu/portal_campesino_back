class UpdateProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :farm, :string
    add_column :products, :price_per_pack, :string
    add_column :products, :sku, :string
    add_column :products, :freshness, :integer
    add_column :products, :category, :string
    add_column :products, :buy_by, :string
    add_column :products, :delivery, :integer
    add_column :products, :delivery_area, :string
    rename_column :products, :quantity, :stock
    rename_column :products, :image_url, :img_url
  end
end
