class Genre < ApplicationRecord

  has_many :item, dependent: :destroy

  # バリデーション。ジャンル登録時の必須入力設定
  validates :name, presence: true

end
