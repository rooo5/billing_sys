class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_code
      t.integer :stock
      t.decimal :price, precision: 10, scale: 2
      t.decimal :tax_percentage, precision: 5, scale: 2

      t.timestamps
    end
    add_index :products, :product_code
  end
end
