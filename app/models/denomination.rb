class Denomination < ApplicationRecord
  validates :available_count, numericality: { greater_than_or_equal_to: 0 }
  validates :value, numericality: { greater_than: 0 }
  validates :value, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[ id value available_count created_at updated_at ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[purchase_denominations]
  end
end
