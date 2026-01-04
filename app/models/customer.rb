class Customer < ApplicationRecord
  has_many :purchases

  validates :email, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[ id email created_at updated_at ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[purchases]
  end
end
