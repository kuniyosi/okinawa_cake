class Order < ApplicationRecord

  has_many :order_details, dependent: :destroy

  belongs_to :customer

  enum status: {
    wait_payment: 0, confirm_payment: 1, in_production: 2, preparing_to_ship: 3, already_shipped: 4
  }

  enum payment_method: {
    credit_card: 0, bank_transfer: 1
  }
end
