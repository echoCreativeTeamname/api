module Api
  class ProductsController < ApiController

    def index #/v1/products
      products = ::Product.all

      page = params[:page] ? params[:page].to_i : 0
      limit = params[:limit] && params[:limit].to_i <= 1000 ? params[:limit].to_i : 500

      products = products.limit(limit).offset(limit*page)

			render json: products, root: "products", meta: {page: page, numberOfItems: limit}, meta_key: "pagination", :each_serializer => ProductSmallerSerializer, status: 200
    end

		def show #/v1/products/:id
      if(product = ::Product.where(uuid: params[:id]).first)
				render json: product, root: false, status: 200
			else
				render json: {error: true, message: "product not found"}, status: 400
			end
    end

		def storechain #/v1/products/:id/storechain
      if(product = ::Product.where(uuid: params[:id]).first)
        render json: product.storechain, root: false, status: 200
      else
        render json: {error: true, message: "product not found"}, status: 400
      end
		end

  end
end
