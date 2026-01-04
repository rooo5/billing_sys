class Purchase < ApplicationRecord
  belongs_to :customer
  has_many :purchase_items, dependent: :destroy

  has_many :purchase_denominations, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[ id customer_id total_amount paid_amount balance_amount created_at updated_at
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[purchase_items customer]
  end
end
