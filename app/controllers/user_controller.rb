class UserController < ApiController

  def login # /v1/authenticate (POST) TODO: bcrypt!
    error_message = {logged_in: false, error: true, message: "email or password are incorrect"}

    params[:email] = params[:email] || ""
    params[:password] = params[:password] || ""

    if(auth_user = User.where(email: params[:email], password: params[:password]).first)
      newtoken = AuthenticationToken.create(user: auth_user, valid_till: Time.now+(3600*12))
      render json: newtoken, status: 200
    else
      render json: error_message, status: 401
    end
  end

  def index # /v1/user (GET)
    if(has_authentication())
      render json: {authenticated: true, user: @auth_user.uuid, url: user_path(@auth_user.uuid)}, status: 200
    end
  end

  def show # /v1/user/:id (GET)
    if(has_authentication(params[:id]))
        render json: @auth_user
    end
  end

  def create # /v1/user (POST)
    if(!params[:email] || !params[:password])
      render json: {error: true, message: ""}, status: 400
    else
      newuser = User.new(email: params[:email], password: params[:password])
      if(newuser.save)
        newtoken = AuthenticationToken.create(user: newuser, valid_till: Time.now+(3600*12))
        render json: {user: newuser.as_json, authentication: newtoken.as_json}, status: 201
      else
        render json: {error: true, message: "Could not save new user to the database"}, status: 500
      end
    end
  end

  def update # /v1/user/:id (PUT/PATCH)
    if(has_authentication)

    end
  end

  def destroy # /v1/user/:id (DELETE)
    if(has_authentication(params[:id]))
      if(params[:delete] == "yes")
        begin
          @auth_user.destroy
          render json: {message: "the user was deleted", deleted: true}, status: 200
        rescue Exception
          render json: {error: true, message: "something went wrong while deleting the user", deleted: false}, status: 500
        end
      else
        render json: {error: true, message: "delete was not set to true", deleted: false}, status: 400
      end
    end
  end

end
