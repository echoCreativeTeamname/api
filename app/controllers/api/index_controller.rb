module Api
  class IndexController < ApiController
    def index
      render json: {message: "welcome to the API, documentation: https://uva.yoeori.nl/documentation", current_version: "v1"}
    end

    def v1
    	render json: {
    		message: "welcome to the V1 API, documentation https://uva.yoeori.nl/documentation/v1",
    		version: "v1",
    		urls: [

          # stores
          {method: "GET", url: "/stores{?latitude,longitude,distance,city}"},
          {method: "GET", url: "/stores/[uuid]"},

          # storechains
          {method: "GET", url: "/storechains"},
          {method: "GET", url: "/storechains/[uuid]"},
          {method: "GET", url: "/storechains/[uuid]/stores"},
          {method: "GET", url: "/storechains/[uuid]/products{?page=0,limit=500}"},

          # products
          {method: "GET", url: "/products{?page=0,limit=500}"},
          {method: "GET", url: "/products/[uuid]"},
          {method: "GET", url: "/products/[uuid]/storechain"},

          # recipes
          {method: "GET", url: "/recipes{?order(=estimated_cost/name/likes/portions/cookingtime)}"},
          {method: "GET", url: "/recipes/[uuid]"},
          {method: "GET", url: "/recipes/[uuid]/storechain/[storechain_uuid]"},

          # authentication (logging in / logging out)
          {method: "POST", url: "/authenticate[?email,password]"},
          {method: "DELETE", url: "/authenticate[?token]"},

          # creating user
          {method: "POST", url: "/user[?email,password]{[city,street,postalcode],[latitude,longitude]}"},

          # user
          {method: "GET", url: "/user[?token]"},
          {method: "GET", url: "/user/[uuid][?token]"},
          {method: "POST", url: "/user/[uuid]/edit[?token]{email,password,[city,street,postalcode],[latitude,longitude]}"},
          {method: "POST", url: "/user/[uuid]/settings[?token]{setting=value}"},
          {method: "POST", url: "/user/[uuid]/address[?token,{[city,street,postalcode],[latitude,longitude]}]"},
          {method: "GET", url: "/user/[uuid]/stores[?token]"},
          {method: "GET", url: "/user/[uuid]/recipes[?token]"},
          {method: "GET", url: "/user/[uuid]/address[?token]"},

          #deleting user
          {method: "DELETE", url: "/user/[uuid][?token,delete(=yes)]"},

        ]
    	}
    end
  end
end
