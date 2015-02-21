class ApiController < ActionController::API

  before_filter :parse_request, :authenticate

  private
  def parse_request
    @json = JSON.parse("{}", symbolize_names: true)
  end

  def authenticate
    @authenticated = @json["token"] && AuthenticationTokens.where(token: @json.token)
  end

end
