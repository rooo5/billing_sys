class PurchaseDenomination < ApplicationRecord
  belongs_to :purchase
  belongs_to :denomination

  enum direction: { in: "in", out: "out" }
end
