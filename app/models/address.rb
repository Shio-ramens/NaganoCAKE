class Address < ApplicationRecord
  def address_display
    '〒' + postal_code + ' ' + name
  end
end
