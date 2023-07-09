class Delivery < ApplicationRecord

  belongs_to :customer

  # 配送先登録時の必須入力の設定。
  validates :name, presence: true
  validates :postcode, presence: true
  validates :address, presence: true

  # postcode.to_sはデータ型をintegerからstringに変換するため。
  def full_address
    '〒' + postcode.to_s + '' + address + '' + name
  end
end
