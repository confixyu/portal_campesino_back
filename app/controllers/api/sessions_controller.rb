module Api
	class SessionsController < ApiController
		skip_before_action :authorized
		
		def create
      user = User.find_by(email: user_params[:email])
      if user && user.authenticate(user_params[:password])
				token = encode_token({
          sub: user.id
        })
				
				render json: {data: {token: token}}
      else
        render json: { error: "Invalid username or password" }, status: 422
      end
		end
		
		private

		def user_params
      params.require(:user).permit(:email, :password )
    end
		
	end
end