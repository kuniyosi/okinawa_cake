class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  # 制作ステータス
  enum production_status: {
     cant_start: 0, awaiting_manufacture: 1, manufacturing: 2, finish: 3
  }
end
