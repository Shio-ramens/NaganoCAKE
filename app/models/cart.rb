class Cart < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, numericality: { greater_than: 0 }
end
