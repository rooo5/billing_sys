class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :product

  def self.ransackable_attributes(auth_object = nil)
    %w[ id id_value product_id purchase_id quantity unit_price total_price tax_amount created_at updated_at ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[product purchase]
  end
end
