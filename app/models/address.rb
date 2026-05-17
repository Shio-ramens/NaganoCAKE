class Address < ApplicationRecord
  def addres_display
    '〒' + postal_code + ' ' + name
  end
end
