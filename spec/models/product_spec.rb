require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "saves successfully when all four fields are present" do
      @categories = Category.new(:name => "test")
      @product = Product.new(:name => "Evergreen", :price => 249.99, :quantity => 5, :category => @categories)
      expect(@product).to be_valid
    end

    it "validates that there must be a name for the product" do
      @categories = Category.new(:name => "test")
      @product = Product.new(:name => nil, :price => 249.99, :quantity => 5, :category => @categories)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it "validates that there must be a price for the product" do
      @categories = Category.new(:name => "test")
      @product = Product.new(:name => "Evergreen", :price => nil, :price_cents => nil, :quantity => 5, :category => @categories)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
      expect(@product.errors.full_messages[1]).to eq("Price is not a number")
      expect(@product.errors.full_messages[2]).to eq("Price can't be blank")
    end

    it "validates that there must be a quantity for the product" do
      @categories = Category.new(:name => "test")
      @product = Product.new(:name => "Evergreen", :price => 249.99, :quantity => nil, :category => @categories)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end

    it "validates that there must be a category for the product" do
      @product = Product.new(:name => "Evergreen", :price => 249.99, :quantity => 5, :category => nil)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages[0]).to eq("Category must exist")
      expect(@product.errors.full_messages[1]).to eq("Category can't be blank")
    end
  end
end