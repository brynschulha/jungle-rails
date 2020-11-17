require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create name: 'Clothing'
      @product = @category.products.new(
        name: 'Sweater',
        price: '20.25',
        quantity: '5'
      )
    end
    it "creates a new product" do
      expect(@product).to be_valid
    end

    it "should not create product without a name" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
      # Could also do this
      # expect(@product).to_not be_valid
    end

    it "should not create product without a price" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it "should not create product without a quantity" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not create product without a category" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
