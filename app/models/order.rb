class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy

  belongs_to :customer

  # 注文ステータス
  enum status: {
    wait_payment: 0, confirm_payment: 1, in_production: 2, preparing_to_ship: 3, already_shipped: 4
  }

  # 支払い方法
  enum payment_method: {
    credit_card: 0, bank_transfer: 1
  }

  def are_all_details_finish?
    (order_details.finish.count == order_details.count) ? true : false
  end
end
