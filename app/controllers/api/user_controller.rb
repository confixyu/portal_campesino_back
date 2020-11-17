module Api
	class UserController < ApiController
		skip_before_action :authorized, only: [:create]

		def show
			render :show, status: :ok
		end

		def create
			user = User.new(user_params)
			if user.valid? && user.save
				render json: { data: user }
			else
				render json: { error: user.errors }, status: 422
			end
		end
		
		private 

		def user_params
      		params.require(:user).permit(:email, :password)
    	end
	end
end
