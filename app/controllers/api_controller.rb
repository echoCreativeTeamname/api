class ApiController < ActionController::API

  private
  def authenticate
    if(params[:token].present?)
      @auth = ::AuthenticationToken.where(token: params[:token]).where(
        "valid_till >= :valid_date",
        {valid_date: Time.now}
      ).first
      if(@auth)
        @auth_user = @auth.user
      end
    end
  end

  def has_authentication
    authenticate
    if(@auth_user)
      true
    else
      render json: {error: true, message: "Not authorized"}, status: 401
      false
    end
  end

end
