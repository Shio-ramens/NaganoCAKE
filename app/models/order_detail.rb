class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

enum :making_status, {
    cannot_make: 0,
    waiting_make: 1,
    making: 2,
    finished: 3
  }
end
