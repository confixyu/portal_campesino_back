class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.float :quantity
      t.string :image_url
      t.integer :user_id

      t.timestamps
    end
  end
end
