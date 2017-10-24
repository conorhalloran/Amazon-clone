require 'rails_helper'

RSpec.describe Product, type: :model do

  def valid_product
    product = FactoryGirl.build(:product)
  end
  
  context ".title" do
    it "must be present" do
      product = valid_product
      product.title = nil
      product.valid?
      expect(product.errors.messages).to have_key(:title)
    end

    it "title must be unique" do
      product1 = valid_product
      product1.title = "Test"
      product1.save
      product = valid_product
      product.title = "Test"
      product.valid?
      expect(product.errors.messages).to have_key(:title)
    end

    it "title get capitalized after being saved" do
      product = valid_product
      product.title = 'title'
      product.save
      expect(product.title).to eq("Title")
    end
  end

  context ".description" do
    it "description is present" do
      product = Product.new
      product.valid?
      expect(product.errors.messages).to have_key(:description)
    end
  end

  context ".price" do
    it "is present" do
      product = valid_product
      product.price = nil
      product.valid?
      expect(product.errors.messages).to have_key(:price)
    end

    it "is greater than or equal to 0" do
      product = valid_product
      product.price = -1
      product.valid?
      expect(product.errors.messages).to have_key(:price)
    end
  end

  context ".search" do
    it "searches by title or description" do
      user = User.create(
        first_name: "User",
        last_name: "Userman",
        email: "user@user.com",
        password: "supersecret",
      )
      category = Category.create name: Faker::Space.planet
      product = Product.create({
          title: 'My Product',
          description: 'lalalalalalalalala',
          price: 1,
          category: category,
          user: user
      })
      result = Product.search('%la%')
      expect(result.first.title || result.first.description).to match(/My/)
    end
  end

  context '.sale_price' do

    it 'is set to price by default' do
    valid_product
    expect(valid_product.sale_price).to eq(valid_product.price)
    end

    it 'must be less than or equal to price' do
      valid_product
      valid_product.sale_price = valid_product.price - 1
      expect(valid_product.sale_price).to eq(valid_product.price -1)
    end
  end
#### END ####
end

