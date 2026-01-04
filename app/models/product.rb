class Product < ApplicationRecord
  has_many :purchase_items

  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :name, :product_code, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[ id name product_code stock price tax_percentage created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[ purchase_items purchase_denominations ]
  end
end
