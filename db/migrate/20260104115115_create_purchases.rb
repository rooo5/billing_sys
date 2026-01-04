class CreatePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :purchases do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_amount, precision: 10, scale: 2
      t.decimal :paid_amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
