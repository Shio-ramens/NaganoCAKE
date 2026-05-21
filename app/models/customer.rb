class Customer < ApplicationRecord
  alias_attribute :password_digest, :encrypted_password
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30fc]+\z/, message: "は全角カタカナで入力してください" }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30fc]+\z/, message: "は全角カタカナで入力してください" }
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/, message: "はハイフンなしの7桁で入力してください" }
  validates :address, presence: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "はハイフンなしの正しい桁数で入力してください" }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, allow_nil: true
end