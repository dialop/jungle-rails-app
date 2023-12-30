require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Example Category')
    end

    it 'is valid with all required attributes' do
      product = Product.new(
        name: 'Example',
        price: 8.99,
        quantity: 6,
        category: @category
      )
      expect(product).to be_valid
    end

    it 'requires a name to be valid' do
      product = Product.new(
        name: nil,
        price: 8.99,
        quantity: 6,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'requires a price to be valid' do
      product = Product.new(
        name: 'Example',
        price: nil,
        quantity: 6,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'requires a quantity to be valid' do
      product = Product.new(
        name: 'Example',
        price: 8.99,
        quantity: nil,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'requires a category to be valid' do
      product = Product.new(
        name: 'Example',
        price: 8.99,
        quantity: 6,
        category: nil
      )
      product.valid?
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
