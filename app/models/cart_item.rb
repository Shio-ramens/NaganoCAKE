class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, numericality: { greater_than: 0 }
end
