module Api
  class ProductsController < ApiController

    def index #/v1/products
      products = Product.all.includes(:storechain)

      page = params[:page] ? params[:page].to_i : 0
      limit = params[:limit] && params[:limit].to_i <= 1000 ? params[:limit].to_i : 500

      if(params[:storechain])
        if(storechain = Storechain.find_by(uuid: params[:storechain]))
          products.where(storechain: storechain)
        else
          render json: {error: true, message: "storechain not found"}, status: 400
        end
      end

      products = products.limit(limit).offset(limit*page)

      number_of_products = Product.all.size

      if(products.size != 0)
        render json: products, root: "products", meta: {page: page, limit: limit, total: number_of_products}, meta_key: "pagination", :each_serializer => ProductSmallerSerializer, status: 200
      else
        render json: {error: true, message: "no products found", "pagination": {page: page, limit: limit, total: number_of_products}}, status: 404
			end
    end

		def show #/v1/products/:id
      if(product = Product.find(params[:id]))
				render json: product, root: false, status: 200
			else
				render json: {error: true, message: "product not found"}, status: 400
			end
    end

		def storechain #/v1/products/:id/storechain
      if(product = Product.find(params[:id]))
        render json: product.storechain, root: false, status: 200
      else
        render json: {error: true, message: "product not found"}, status: 400
      end
		end

  end
end
