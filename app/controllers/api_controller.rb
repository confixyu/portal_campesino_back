class ApiController < ActionController::API
	before_action :authorized

	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
	def record_not_found(error)
		render json: { error: error.message }, status: :not_found
	end

	rescue_from ArgumentError, :with => :argument_error
	def argument_error(error)
		render json: { error: error.message }, status: 422
	end

	private

	def encode_token(payload)
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
  end

  def auth_header
    request.headers['Authorization']
  end

  def secret_header
    request.headers['secret-key']
  end

  def decoded_token
    body_param_token = params['user'] ? params['user']['token'] : nil
    if auth_header || body_param_token || secret_header
      token = nil

      if auth_header
        token = auth_header.split(' ')[1]
      elsif secret_header
        token = secret_header
      elsif body_param_token
        token = body_param_token
      end

      begin
        JWT.decode(token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['sub']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user #&& @user.auth_token != nil
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end