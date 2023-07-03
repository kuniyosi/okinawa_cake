class Item < ApplicationRecord

  has_one_attached :item_image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  belongs_to :genre

end
