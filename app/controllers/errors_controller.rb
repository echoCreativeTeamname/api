class ErrorsController < ApiController

  def not_found # 404
    render json: {error: true, message: "page not found"}, status: 404
  end

  def server_error # 500
    render json: {error: true, message: "something unknown went wrong on the server"}, status: 500
  end

  def unprocessable # 422
    render json: {error: true, message: "something unknown went wrong on the server"}, status: 422
  end

end
