class UserController < ApiController

  def index # /v1/user (GET)

  end

  def login # /v1/authenticate

  end

  def show # /v1/user/:id (GET)
    if(has_authentication)

    end
  end

  def create # /v1/user (POST)
    if(!params[:email] || !params[:password])
      render json: {error: true, message: "Couldn't find password or email address"}, status: 500
    else
      newuser = User.new(email: params[:email], password: params[:password])
      if(newuser.save)
        render json: newuser, status: 201
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
    if(has_authentication)

    end
  end

end
