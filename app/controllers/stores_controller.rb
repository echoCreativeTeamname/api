Dir[Rails.root + 'app/models/**/*.rb'].each do |path|
  require path
end

class StoresController < ApplicationController

  def all #/v1/stores
    render json: ::Store.all, root: false
  end

  def store #/v1/store/:uuid
  	render json: ::Store.where(uuid: params[:uuid]).first, root: false, :serializer => StorefullSerializer
  end

end
