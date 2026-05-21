class Order < ApplicationRecord
  enum :payment_method, {credit_card: 0, transfer: 1 }
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum :status, {
    waiting_payment: 0,  # 入金待ち
    confirm_payment: 1,  # 入金確認
    making: 2,           # 製作中
    preparing_ship: 3,   # 発送準備中
    sent: 4              # 発送済み
  }
end
