class StoresController < ApiController

  def index #/v1/stores
    stores = ::Store.all

    if(city = params[:city])
      stores = stores.where(city: city)
    end

    if(params[:latitude] && params[:longitude]) # TODO sorting (OPTIONAL!)
      distance_la = params[:distance] ? params[:distance].to_f : 0.03
      distance_lo = params[:distance] ? params[:distance].to_f : 0.03
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      stores = stores.where(latitude: (latitude-distance_la)..(latitude+distance_la), longitude: (longitude-distance_lo)..(longitude+distance_lo))
    end

    render json: stores, root: false, status: 200
  end

  def show #/v1/store/:id
  	render json: ::Store.where(uuid: params[:id]).distinct.first, root: false, :serializer => StorefullSerializer, status: 200
  end

end
