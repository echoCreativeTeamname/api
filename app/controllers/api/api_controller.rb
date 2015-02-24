class ApiController < ActionController::API
  rescue_from ActionController::RoutingError, :with => :error_page_not_found

  def error_page_not_found
    render json: {error: true, message: "page not found"}, status: 404
  end

  private
  def authenticate
    if(params[:token].present?)
      @auth = AuthenticationToken.where(token: params[:token]).where(
        "valid_till >= :valid_date",
        {valid_date: Time.now}
      ).first
      if(@auth)
        @auth_user = @auth.user
      end
    end
  end

  def has_authentication(user_uuid = "")
    authenticate unless(@auth_user)
    if(@auth_user && (user_uuid == "" || @auth_user.uuid == user_uuid))
      true
    else
      render json: {authenticated: false, error: true, message: "not authenticated"}, status: 401
      false
    end
  end

end
