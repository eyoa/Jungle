require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before (:each) do
      @category = Category.create(name: 'test')
    end

    it 'creates a product' do
      product = Product.new
      product.name = 'new product'
      product.description = 'description'
      product.category_id = @category.id
      product.quantity = 2
      product.image = 'imagepath'
      product.price = 32.99
    
      expect{product.save!}.to change{Product.count}.by(1)
    end

    it 'validates there must be a name' do
      product = Product.new
      product.description = 'description'
      product.category_id = @category.id
      product.quantity = 2
      product.image = 'imagepath'
      product.price = 32.99
    
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates there must be a price' do
      product = Product.new
      product.name = 'new product'
      product.description = 'description'
      product.category_id = @category.id
      product.quantity = 2
      product.image = 'imagepath'

      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")      
    end

    it 'validates there must be a quantity' do
      product = Product.new
      product.name = 'new product'
      product.description = 'description'
      product.category_id = @category.id
      product.image = 'imagepath'
      product.price = 32.99

      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")      
    end

    it 'validates there must be a quantity' do
      product = Product.new
      product.name = 'new product'
      product.description = 'description'
      product.quantity = 2
      product.image = 'imagepath'
      product.price = 32.99

      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")      
    end

    
    
  end
end
