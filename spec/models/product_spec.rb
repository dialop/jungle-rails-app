require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do

      @category = Category.create(name: 'Example Category')
    end

    # Check if a product with all necessary attributes is successfully valid
    it 'is valid with all required attributes' do
      product = Product.new(
        name: 'Example',
        price: 8.99,
        quantity: 6,
        category: @category
      )
      expect(product).to be_valid
    end
    

    # Ensure a product is invalid without a name
    it 'requires a name to be valid' do
      product = Product.new(
        name: nil,
        price: 8.99,
        quantity: 6,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include ("Name cannot be blank.")
    end

    # Verify that a product is invalid without a price
    it 'requires a price to be valid' do
      product = Product.new(
        name: 'Example',
        price: nil,
        quantity: 6,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Price cannot be blank.")
    end

    # Confirm that a product is invalid without a quantity
    it 'requires a quantity to be valid' do
      product = Product.new(
        name: 'Example',
        price: 8.99,
        quantity: nil,
        category: @category
      )
      product.valid?
      expect(product.errors.full_messages).to include("Quantity cannot be blank.")
    end

    # Ensure a product is invalid without a category
    it 'requires a category to be valid' do
      product = Product.new(
        name: 'Example',
        price: 8.99,
        quantity: 6,
        category: nil
      )
      product.valid?
      expect(product.errors.full_messages).to include("Category cannot be blank.")
    end

  end 
end 
