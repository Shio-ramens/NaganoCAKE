class Item < ApplicationRecord
  belongs_to :genre

  def with_tax_price
    (price * 1.1).floor
  end

  has_one_attached :image

  validates :price, presence: true
end
