class StoresController < ApiController

  def index #/v1/stores
    stores = ::Store.all

    if(city = params[:city])
      stores = stores.where(city: city)
    end

    if(params[:latitude] && params[:longitude])

      distance = params[:distance] ? params[:distance].to_f : 0.06

      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      stores = stores.where(latitude: (latitude-distance)..(latitude+distance), longitude: (longitude-distance)..(longitude+distance))
    end

    render json: stores, root: false, status: 200
  end

  def show #/v1/store/:id
  	render json: ::Store.where(uuid: params[:id]).first, root: false, :serializer => StorefullSerializer, status: 200
  end

end
