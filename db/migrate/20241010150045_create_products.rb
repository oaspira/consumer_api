class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :product_name
      t.string :shop_name
      t.integer :product_category_id
      t.string :country
      t.string :brand
      t.decimal :price
      t.string :url

      t.timestamps
    end
  end
end
