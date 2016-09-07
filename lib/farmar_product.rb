module FarMar
  class Product
    attr_reader :id, :name, :vendor_id

    def initialize(id, name, vendor_id)
      @id = id.to_i
      @name = name
      @vendor_id = vendor_id.to_i
    end

    def self.all
      all_products = []
      CSV.read('support/products.csv').each do |line|
        all_products << FarMar::Product.new(line[0], line[1], line[2])
      end
      return all_products
    end

    def self.find(id)
      all_products = self.all
      all_products.each do |product|
        if product.id == id
          return product
        end
      end
    end

    def vendor
      FarMar::Vendor.find(@vendor_id)
    end

    def sales
      product_sales = FarMar::Sale.all.select do |sale|
        sale.product_id == @id
      end
      return product_sales
    end

    def number_of_sales
      sales.length
    end

    def self.by_vendor(vendor_id)
      vendor_products = self.all.select do |product|
        product.vendor_id == vendor_id
      end
      return vendor_products
    end

  end
end
