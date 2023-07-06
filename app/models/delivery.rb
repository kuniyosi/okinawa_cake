class Delivery < ApplicationRecord

  belongs_to :customer

  # postcode.to_sはデータ型をintegerからstringに変換するため
  def full_address
    '〒' + postcode.to_s + '' + address + '' + name
  end
end
