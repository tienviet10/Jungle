require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(:name => "Perennials");
    end

    let(:product) { Product.new(:name => "Viet", :price_cents => 1234, :quantity => 6, :category => @category) }
    
    it 'error when name is not presented' do
      product.name = nil
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    it 'error when price is not presented' do
      product.price_cents = nil
      product.save
      expect(product.errors.full_messages).to include("Price cents can't be blank")
    end
    it 'error when quantity is not presented' do
      product.quantity = nil
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'error when category is not presented' do
      product.category = nil
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
