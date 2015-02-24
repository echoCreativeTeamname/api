module Api
  class IndexController < ApiController
    def index
      render json: {message: "welcome to the API, documentation: https://uva.yoeori.nl/documentation", current_version: "v1"}
    end

    def v1
    	render json: {
    		message: "welcome to the V1 API, documentation https://uva.yoeori.nl/documentation/v1",
    		version: "v1_beta2",
    		urls: [
          "/stores{?latitude,longitude,city}",
          "/stores/{uuid}",
          "/authenticate",
          "/user",
          "/user/{uuid}",
          "/user/{uuid}/address",
          "/user/{uuid}/settings",
          "/user/{uuid}/edit",
          "/user/logout"
        ]
    	}
    end
  end
end
