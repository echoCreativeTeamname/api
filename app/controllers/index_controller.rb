class IndexController < ApiController
  def index
    render json: {message: "Welcome to the API, documentation: https://uva.yoeori.nl/documentation", current_version: "v1"}
  end

  def v1
  	render json: {
  		message: "Welcome to the V1 API, documentation https://uva.yoeori.nl/documentation/v1",
  		version: "v1_beta1",
  		urls: ["/stores", "/stores/:uuid"]
  	}
  end
end
