module Api
  class UserController < ApiController

    def login # /v1/authenticate (POST) TODO: bcrypt!
      error_message = {logged_in: false, error: true, message: "incorrect email or password"}

      params[:email] = params[:email] || ""
      params[:password] = params[:password] || ""

      if(params[:password].size > 72)
        render json: {logged_in: false, error: true, message: "password too long"}, status: 401
      elsif(auth_user = User.find_by(email: params[:email]).try(:authenticate, params[:password]))
        newtoken = AuthenticationToken.create(user: auth_user, valid_till: Time.now+(3600*24*7))
        render json: newtoken, root: false, status: 200
      else
        render json: error_message, status: 401
      end
    end

    def index # /v1/user (GET)
      if(has_authentication())
        render json: {authenticated: true, user: @auth_user.uuid, url: api_userinfo_path(@auth_user.uuid)}, status: 200
      end
    end

    def show # /v1/user/:id (GET)
      if(has_authentication(params[:id]))
        render json: @auth_user, root: "user"
      end
    end

    def create # /v1/user (POST)

      if(!params[:email] || !params[:password])
        render json: {error: true, message: "required arguments: email, password"}, status: 400
      elsif(params[:password].size > 72)
        render json: {error: true, message: "password too long"}, status: 401
      elsif(User.where(email: params[:email]).first)
        render json: {error: true, message: "user with this email address already exists"}, status: 400
      else
        newuser = User.new(email: params[:email], password: params[:password])

        if(newuser.save)

          #Setup authentication
          newtoken = AuthenticationToken.create(user: newuser, valid_till: Time.now+(3600*24*7))

          @auth_user = newuser
          @auth = newtoken

          if((params[:city] && params[:street] && params[:postalcode]) || (params[:latitude] && params[:longitude]))
            update_address(false)
          end

          render json: {
            user: ::UserSerializer.new(newuser, root: false).as_json,
            authentication: ::AuthenticationTokenSmallSerializer.new(newtoken, root:false).as_json
          }, status: 201

        else
          render json: {error: true, message: "could not save new user to the database"}, status: 500
        end
      end
    end

    def update # /v1/user/:id/edit (POST)
      if(has_authentication)
        can_change = ["email", "password"]
        values = {}

        User.column_names.each do |column|
          next unless can_change.include? column
          values[column.to_sym] = params[column.to_sym] if params[column.to_sym]
        end

        if((params[:city] && params[:street] && params[:postalcode]) || (params[:latitude] && params[:longitude]))
          update_address(false)
        end

        if(@auth_user.update_attributes(values))
          render json: @auth_user, root: "user", status: 200
        else
          render json: {error: true, message: "something went wrong while saving"}, status: 500
        end
      end
    end

    def update_settings # /v1/user/:id/settings (POST)
      rs_status = 200
      if(has_authentication(params[:id]))
        @auth_user.set_setting(:healthiness_level, 300)
        User::DEFAULT_SETTINGS.each do |key, value|
          if(params[key])
            if(@auth_user.set_setting(key, params[key]))
              rs_status = 201
            else
              render json: {error: true, message: "something went wrong while saving the user's settings"}, status: 500
            end
          end
        end
      end
      render json: @auth_user, root: "user", meta: {updated_settings: rs_status != 200}, meta_key: "status", status: rs_status
    end

    def update_address(renderpage = true)
      if(has_authentication)
        begin
          address = Google.geocode(
            (params[:latitude] && params[:longitude]) ? {latitude: params[:latitude], longitude: params[:longitude]} : {street: params[:street], city: params[:city], postalcode: params[:postalcode]}
          )

          # Update user
          @auth_user.street = address[:street]
          @auth_user.city = address[:city]
          @auth_user.postalcode = address[:postalcode]
          @auth_user.latitude = address[:latitude]
          @auth_user.longitude = address[:longitude]
          @auth_user.update_stores
          @auth_user.save

          if(renderpage == true)
            render json: @auth_user, root: "user"
          end

        rescue Google::Exceptions::InvalidLocationError
          if(renderpage == true)
            render json: {error: true, message: "the given address/location was invalid"}, status: 400
          end
        rescue Google::Exceptions::APILimitReachedError
          if(renderpage == true)
            render json: {error: true, message: "we temporarily don't have access to the Google Geocoding API"}, status: 503
          end
        rescue ::ArgumentError
          if(renderpage == true)
            render json: {error: true, message: "wrong arguments supplied"}, status: 400
          end
        rescue
          if(renderpage == true)
            render json: {error: true, message: "something went wrong while geocoding the user's address"}, status: 500
          end
        end
      end
    end

    def destroy # /v1/user/:id (DELETE)
      if(has_authentication(params[:id]))
        if(params[:delete] == "yes")
          begin
            @auth_user.destroy
            render json: {message: "the user was deleted, all tokens/settings associated with the user have also been deleted", deleted: true}, status: 200
          rescue Exception
            render json: {error: true, message: "something went wrong while deleting the user", deleted: false}, status: 500
          end
        else
          render json: {error: true, message: "delete was not set to true", deleted: false}, status: 400
        end
      end
    end

    def logout # /v1/authenticate (DELETE)
      if(has_authentication())
        begin
          @auth.destroy
          render json: {message: "token was revoked, user logged out succesfully", logged_out: true}, status: 200
        rescue Exception
          render json: {error: true, message: "something went wrong while logging out", logged_out: false}, status: 500
        end
      end
    end
  end
end
