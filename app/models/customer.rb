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
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true

  validates :password,
  length: { minimum: 6 },
  allow_nil: true
end