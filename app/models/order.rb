class Order < ApplicationRecord
  after_create :reduce_product

  has_many :line_items
  monetize :total_cents, numericality: true
  validates :stripe_charge_id, presence: true

  def reduce_product
    p "Lets modify the product quantity!"
    self.line_items.each do |item|
      product = Product.find(item.product_id)
      product.update(quantity: product.quantity - item.quantity)
    end
  end
end
