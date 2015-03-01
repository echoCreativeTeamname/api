module Api
  class StorechainsController < ApiController

    def index #/v1/storechains
      storechains = ::Storechain.all
      render json: storechains, root: false, status: 200
    end

		def show #/v1/storechains/:id
			if(storechain = ::Storechain.where(uuid: params[:id]).distinct.first)
				render json: storechain, root: false, status: 200
			else
				render json: {error: true, message: "storechain not found"}, status: 400
			end
    end

		def stores #/v1/storechains/:id/stores
			if(storechain = ::Storechain.where(uuid: params[:id]).distinct.first)
				render json: storechain.stores.includes(:chain), root: false, status: 200
			else
				render json: {error: true, message: "storechain not found"}, status: 400
			end
		end

		def products #/v1/storechains/:id/products
			if(storechain = ::Storechain.where(uuid: params[:id]).distinct.first)
        products = storechain.products

        page = params[:page] ? params[:page].to_i : 0
        limit = params[:limit] && params[:limit].to_i <= 1000 ? params[:limit].to_i : 500

        products = products.limit(limit).offset(limit*page)

				render json: products, root: "products", meta: {page: page, numberOfItems: limit}, meta_key: "pagination", :each_serializer => ProductSmallSerializer, status: 200
			else
				render json: {error: true, message: "storechain not found"}, status: 400
			end
		end

  end
end
