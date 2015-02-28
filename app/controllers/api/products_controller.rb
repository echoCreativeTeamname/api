module Api
  class ProductsController < ApiController # TODO

    def index #/v1/storechains
      storechains = ::Storechains.all
      render json: storechains, root: false, status: 200
    end
		
		def show #/v1/storechains/:id
			if(storechain = ::Storechains.where(uuid: params[:id]).distinct.first)
				render json: storechain, root: false, status: 200
			else
				render json: {error: true, message: "storechain not found"}, root: false, status: 400
			end
    end
		
		def stores #/v1/storechains/:id/stores
			if(stores = ::Storechains.where(uuid: params[:id]).distinct.first.stores)
				render json: stores, root: false, status: 200
			else
				render json: {error: true, message: "storechain not found"}, root: false, status: 400
			end
		end
		
		def products #/v1/storechains/:id/products
			if(stores = ::Storechains.where(uuid: params[:id]).distinct.first.products)
				render json: stores, root: false, status: 200
			else
				render json: {error: true, message: "storechain not found"}, root: false, status: 400
			end
		end

  end
end
