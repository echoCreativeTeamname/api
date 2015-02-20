class IndexController < ApplicationController
  def index
    render json: {message: "Welcome to the Ambrosia api", responseCode: "200"}
  end
end
