require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      cat1 = Category.find_or_create_by! name: 'Evergreens'
      @product1 = Product.create!({
        name:  'Lion Grapevine',
        description: "The Lion Grapevine is an uncommon, modest plant and can be found only in some humid regions. It blooms once a year, for 4 months.
        It has wide, squared leaves, which are usually purple. It also grows tiny flowers, which can be dark bronze and orange.
        
        These plants grow in large groups, but it's really tricky to control and maintain their growth.
        They can be brewed as tea.
        
        As a defense mechanism the Lion Grapevine grows small thorns.
        They rely on wind pollination to reproduce. Once pollinated, they grow small, inedible fruits.",
        image: open_asset('plante_3.jpg'),
        quantity: 4,
        price: 34.49,
        category: cat1
      })
      @product2 = Product.create!({
        name:  'Bone Coneflower',
        description: "The Bone Coneflower is an uncommon, small plant and can be found only in some forests. It blooms in early spring.
        It has thick, paired leaves, which are usually blue-green. It also grows large flowers, which can be dark blue, dark orange and light brown.
        
        These plants grow within short distances from each other, but it's a bit tricky to control and maintain their growth.
        They can be used to treat wounds.
        
        As a defense mechanism the Bone Coneflower is poisonous for most creatures.
        They rely on self pollination to reproduce. Once pollinated, they grow fairly large, inedible fruits.",
        image: open_asset('plante_4.jpg'),
        quantity: 10,
        price: 24.99,
        category: cat1
      })
    end
 
    it 'deducts quantity from products based on their line item quantities' do
      @order = Order.new(
        email: "viettran101294@gmail.com",
        total_cents: 10083,
        stripe_charge_id: "stripe_charge.id", # returned by stripe
      )

      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: 1233,
        total_price: 1233
      )
      @order.line_items.new(
        product: @product2,
        quantity: 2,
        item_price: 3234,
        total_price: 3234 * 2
      )

      @order.save!

      @product1.reload
      @product2.reload

      expect(@product1.quantity).to eql(3)
      expect(@product2.quantity).to eql(8)
    end

    it 'does not deduct quantity from products that are not in the order' do
      @order = Order.new(
        email: "viettran101294@gmail.com",
        total_cents: 10083,
        stripe_charge_id: "stripe_charge.id", # returned by stripe
      )

      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: 1233,
        total_price: 1233
      )

      @order.save!

      @product1.reload

      expect(@product1.quantity).to eql(3)
      expect(@product2.quantity).to eql(10)
    end
  end
end