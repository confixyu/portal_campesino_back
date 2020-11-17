module Api
	class ProductsController < ApiController
		
		def index
			render json: { data: @user.products }
		end

		def create
      product = @user.products.create(product_params)
      if product.save
        render json: { data: product }, status: :created
      else
        render json: { error: product.errors }, status: 422
      end
    end
		
		private

		def product_params
			params.require(:product).permit(:name, :description, :price, :quantity)
	end
		
	end
end
