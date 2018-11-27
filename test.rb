require './app'
require 'minitest/autorun'

describe Product do

  describe "#Create" do
    describe "When creating a product" do
      it "must respond positively" do
        @product = Product.new({name: 'Helado', value: '1500', brand: 'Colombina', description: ' ', quantity: '2'})
        @product.save.must_equal(true)
      end
    end

    describe "when creating a product without the fields required" do
      it "must respond negatively if the name is missing" do
        @product = Product.new({name: '', value: '2000'})
        @product.save.must_equal(false)
      end

      it "must respond negatively if the value is missing" do
        @product = Product.new({name: 'Alpin', value: '', brand: 'Alpina'})
        @product.save.must_equal(false)
      end

      it "must respond negatively if the brand is missing" do
        @product = Product.new({name: 'Gatorade', value: '2500', brand: ''})
        @product.save.must_equal(false)
      end
    end
  end

  describe "#Find" do
    describe "when looking for a data by valid ID" do
      it "must gets the data of product" do
        @product = Product.find(78)[:name].must_equal("Helado")
      end
    end
  end

  describe "#Delete" do
    describe "when deleted a product" do
      it "must respond positively" do
        @product = Product.delete(79).must_equal(1)
      end
    end
  end

  describe "#Update" do
    describe "when the data of a product is updated" do
      it "must respond positively" do
        @product = Product.find(59)
        attrs = { name: "Pera", value: 1500, brand: "Colombina", description: "Me Encanta", quantity: 50 }
        @product.update(attrs).must_equal(true)
      end
    end

    describe "when the data of product if updating without the fields required" do
      it "must respond negatively if the name is missing" do
        @product = Product.find(59)
        attrs = { name: "", value: 3000, brand: "Colombina", description: "Me Encanta", quantity: 50 }
        @product.update(attrs).must_equal(false)
      end

      it "must respond negatively if the value is missing" do
        @product = Product.find(59)
        attrs = { name: "Pera", value: "", brand: "Colombina", description: "Me Encanta", quantity: 50 }
        @product.update(attrs).must_equal(false)
      end

      it "must respond negatively if the brand is missing" do
        @product = Product.find(59)
        attrs = { name: "Pera", value: 3000, brand: "", description: "Me Encanta", quantity: 50 }
        @product.update(attrs).must_equal(false)
      end
    end
  end

  describe "#Where" do
    describe "when filtered with the parameters name, value or brand" do
      it "must gets the data that matches the name" do
        search = "Pera"
        @products = (Product.where("brand ILIKE :query OR name ILIKE :query",
          query: "%#{search}%")
        )
        @products.any?.must_equal(true)
      end

      it "must gest the data that matches the brand" do
        search = "Nestle"
        @products = (Product.where("brand ILIKE :query OR name ILIKE :query",
          query: "%#{search}%")
        )
        @products.any?.must_equal(true)
      end
    end

    describe "when filtered with the parameters name, value or brand and can not find matches" do
      it "must gets a message of error" do
        search = "Mango"
        @products = (Product.where("brand ILIKE :query OR name ILIKE :query",
          query: "%#{search}%"))
        @products.any?.must_equal(false)
      end
    end
  end

end
