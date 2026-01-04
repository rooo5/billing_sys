class AddBalanceToPurchases < ActiveRecord::Migration[7.2]
  def change
    add_column :purchases, :balance_amount, :decimal
  end
end
