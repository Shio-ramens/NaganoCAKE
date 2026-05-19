class Admin < ApplicationRecord
  alias_attribute :password_digest, :encrypted_password
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email, with: ->(e) { e.strip.downcase }
end
