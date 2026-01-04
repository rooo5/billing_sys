class CreatePurchaseDenominations < ActiveRecord::Migration[7.2]
  def change
    create_table :purchase_denominations do |t|
      t.references :purchase, null: false, foreign_key: true
      t.references :denomination, null: false, foreign_key: true
      t.integer :count
      t.string :direction

      t.timestamps
    end
  end
end
